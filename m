From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Thu, 7 Dec 2017 14:40:45 +0200
Subject: [PATCH V6 3/7] device property: Introduce a common API to fetch
 device match data
In-Reply-To: <1512493493-6464-4-git-send-email-okaya@codeaurora.org>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-4-git-send-email-okaya@codeaurora.org>
Message-ID: <20171207124044.utyrn2mzzyml42b2@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 12:04:48PM -0500, Sinan Kaya wrote:
> @@ -101,6 +103,8 @@ struct fwnode_operations {
>  	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
>  	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
>  				    struct fwnode_endpoint *endpoint);
> +	void *(*get_match_data)(const struct fwnode_handle *fwnode,
> +				struct device *dev);

You can make dev const, too.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
