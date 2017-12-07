From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 7 Dec 2017 14:10:29 +0100
Subject: [PATCH V6 4/7] OF: properties: Implement get_match_data() callback
In-Reply-To: <1512493493-6464-5-git-send-email-okaya@codeaurora.org>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-5-git-send-email-okaya@codeaurora.org>
Message-ID: <20171207141029.575c0a03@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue,  5 Dec 2017 12:04:49 -0500 Sinan Kaya wrote:
> Now that we have a get_match_data() callback as part of the firmware node,
> implement the OF specific piece for it.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/of/property.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 264c355..9964169 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -981,6 +981,12 @@ static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  	return 0;
>  }
>  
> +void *of_fwnode_get_match_data(const struct fwnode_handle *fwnode,
> +			       struct device *dev)
Shouldn't this be 'const void *of_fwnode_get_match_data'



Lothar Wa?mann
