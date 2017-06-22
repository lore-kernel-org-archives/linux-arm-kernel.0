From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 22 Jun 2017 11:10:46 +0200
Subject: [PATCH] nvmem: rockchip-efuse: amend compatible rk322x-efuse to
 rk3228-efuse
In-Reply-To: <1498121207-24941-1-git-send-email-frank.wang@rock-chips.com>
References: <1498121207-24941-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <48352151.OspxPMcbie@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 22. Juni 2017, 16:46:47 CEST schrieb Frank Wang:
> As the comments from Heiko Stuebner <heiko@sntech.de> that compatible
> should not contain any placeholders, this patch fix it for rk3228 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

not sure how this slipped through in the first place, but the rk322x
compatible would only make it into 4.13, so it should still be fine to
simply correct that issue, before it hits mainline.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt | 2 +-
>  drivers/nvmem/rockchip-efuse.c                             | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> index 194926f..1ff02afd 100644
> --- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> @@ -4,7 +4,7 @@ Required properties:
>  - compatible: Should be one of the following.
>    - "rockchip,rk3066a-efuse" - for RK3066a SoCs.
>    - "rockchip,rk3188-efuse" - for RK3188 SoCs.
> -  - "rockchip,rk322x-efuse" - for RK322x SoCs.
> +  - "rockchip,rk3228-efuse" - for RK3228 SoCs.
>    - "rockchip,rk3288-efuse" - for RK3288 SoCs.
>    - "rockchip,rk3399-efuse" - for RK3399 SoCs.
>  - reg: Should contain the registers location and exact eFuse size
> diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
> index a0d4ede..63e3eb5 100644
> --- a/drivers/nvmem/rockchip-efuse.c
> +++ b/drivers/nvmem/rockchip-efuse.c
> @@ -170,7 +170,7 @@ static const struct of_device_id rockchip_efuse_match[] = {
>  		.data = (void *)&rockchip_rk3288_efuse_read,
>  	},
>  	{
> -		.compatible = "rockchip,rk322x-efuse",
> +		.compatible = "rockchip,rk3228-efuse",
>  		.data = (void *)&rockchip_rk3288_efuse_read,
>  	},
>  	{
> 
