module Pipedrive
  class Deal < Base

    def add_product(opts = {})
      res = post "#{resource_path}/#{id}/products", :body => opts
      res.success? ? res['data']['product_attachment_id'] : bad_response(res,opts)
    end

    def products
      Product.new_list(get "#{resource_path}/#{id}/products")
    end
    
    def remove_product product_attachment_id
      res = delete "#{resource_path}/#{id}/products", { :body => { :product_attachment_id => product_attachment_id } }
      res.success? ? nil : bad_response(res,product_attachment_id)
    end

    def activities
      Activity.new_list(get "#{resource_path}/#{id}/activities")
    end

    def files
      File.new_list(get "#{resource_path}/#{id}/files")
    end

    def notes(opts = {:sort_by => 'add_time', :sort_mode => 'desc'})
      Note.new_list( get("/notes", :query => opts.merge(:deal_id => id) ) )
    end
    
    def participants
      Person.new_list(get "#{resource_path}/#{id}/participants")
    end
  end
end
