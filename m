From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 1 Aug 2011 12:55:49 +0100
Subject: [PATCH 1/2] of: address: use resource_size helper
In-Reply-To: <1311364042-8325-1-git-send-email-balbi@ti.com>
References: <1311364042-8325-1-git-send-email-balbi@ti.com>
Message-ID: <20110801115549.GA4566@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 10:47:21PM +0300, Felipe Balbi wrote:
> that should be the approved way of calculating
> the size of resources. No functional changes.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applied, thanks.

> ---
>  drivers/of/address.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index deefc0c..6e7b2cf 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -624,6 +624,6 @@ void __iomem *of_iomap(struct device_node *np, int index)
>  	if (of_address_to_resource(np, index, &res))
>  		return NULL;
>  
> -	return ioremap(res.start, 1 + res.end - res.start);
> +	return ioremap(res.start, resource_size(&res));
>  }
>  EXPORT_SYMBOL(of_iomap);
> -- 
> 1.7.6
> 
