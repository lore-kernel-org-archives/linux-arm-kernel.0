From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Feb 2017 10:21:32 -0800
Subject: [PATCH 03/11] drm/sun4i: Add end of list element for
 sun4i_layers_init's returned list
In-Reply-To: <20170223080543.6659-4-wens@csie.org>
References: <20170223080543.6659-1-wens@csie.org>
 <20170223080543.6659-4-wens@csie.org>
Message-ID: <20170223182132.lziv75zybuhp7wjb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 04:05:35PM +0800, Chen-Yu Tsai wrote:
> The number of defined planes in sun4i_layer is unknown to other parts
> of the sun4i drm driver. Since the return value of sun4i_layers_init
> is a list of layers, make it return 1 more empty layer as an end of
> list guard value.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied. Thanks!

I guess you could also add a comment about what it returns, just so
it's obvious that it's a NULL terminated list of items

Maxime

> ---
>  drivers/gpu/drm/sun4i/sun4i_layer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
> index 41bc0f860f5c..0b703fb02656 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -139,7 +139,7 @@ struct sun4i_layer **sun4i_layers_init(struct drm_device *drm)
>  	struct sun4i_layer **layers;
>  	int i;
>  
> -	layers = devm_kcalloc(drm->dev, ARRAY_SIZE(sun4i_backend_planes),
> +	layers = devm_kcalloc(drm->dev, ARRAY_SIZE(sun4i_backend_planes) + 1,
>  			      sizeof(*layers), GFP_KERNEL);
>  	if (!layers)
>  		return ERR_PTR(-ENOMEM);
> -- 
> 2.11.0
> 

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170223/eccea980/attachment.sig>
