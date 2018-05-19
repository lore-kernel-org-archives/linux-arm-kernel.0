From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 19 May 2018 18:08:30 +0200
Subject: [PATCH v3 24/26] drm/bridge: remove the .of_node member
In-Reply-To: <20180516101510.13215-25-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
 <20180516101510.13215-25-peda@axentia.se>
Message-ID: <5194502.mIuqRB9jFM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 16. Mai 2018, 12:15:08 CEST schrieb Peter Rosin:
> It is unused.
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Peter Rosin <peda@axentia.se>

> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 557e0079c98d..e77d4c909582 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -377,8 +377,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  	}
>  	if (lvds->panel)
>  		remote = lvds->panel->dev->of_node;
> -	else if (lvds->bridge->of_node)
> -		remote = lvds->bridge->of_node;
>  	else
>  		remote = lvds->bridge->odev->of_node;
>  	if (of_property_read_string(dev->of_node, "rockchip,output", &name))

for the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>
