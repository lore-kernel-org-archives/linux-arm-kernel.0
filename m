From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Thu, 18 Feb 2016 17:57:49 +0800
Subject: [PATCH v2.1 2/4] spi: rockchip: add bindings for rk3399 spi
In-Reply-To: <2327512.KAqs6H56Km@phil>
References: <1455762983-29980-1-git-send-email-jay.xu@rock-chips.com>
 <1455762983-29980-3-git-send-email-jay.xu@rock-chips.com>
 <20160218094108.GA7129@sirena.org.uk> <2327512.KAqs6H56Km@phil>
Message-ID: <56C5959D.3030806@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko

Thank you for you kindly explain, now I got your comments.

? 18/02/2016 17:47, Heiko Stuebner ??:
> From: Xu Jianqun <jay.xu@rock-chips.com>
>
> Add devicetree bindings for Rockchip rk3399 spi which found on
> Rockchip rk3399 SoCs.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Hi Jianqun,
> what Mark means is the following.
>
>   Documentation/devicetree/bindings/spi/spi-rockchip.txt | 1 +
>   drivers/spi/spi-rockchip.c                             | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> index 0c491bd..1b14d69 100644
> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> @@ -9,6 +9,7 @@ Required Properties:
>       "rockchip,rk3066-spi" for rk3066.
>       "rockchip,rk3188-spi", "rockchip,rk3066-spi" for rk3188.
>       "rockchip,rk3288-spi", "rockchip,rk3066-spi" for rk3288.
> +    "rockchip,rk3399-spi", "rockchip,rk3066-spi" for rk3399.
>   - reg: physical base address of the controller and length of memory mapped
>          region.
>   - interrupts: The interrupt number to the cpu. The interrupt specifier format
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 79a8bc4..345fefd 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -868,6 +868,7 @@ static const struct of_device_id rockchip_spi_dt_match[] = {
>   	{ .compatible = "rockchip,rk3066-spi", },
>   	{ .compatible = "rockchip,rk3188-spi", },
>   	{ .compatible = "rockchip,rk3288-spi", },
> +	{ .compatible = "rockchip,rk3399-spi", },
I'm a little confuse, I have upstreamed rockchip-i2s, and the i2s driver 
set the compatible like:
- compatible: should be one of the followings
    - "rockchip,rk3066-i2s": for rk3066
    - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
    - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
    - "rockchip,rk3399-i2s", "rockchip,rk3066-i2s": for rk3399
and the driver only has
static const struct of_device_id rockchip_i2s_match[] = {
	{ .compatible = "rockchip,rk3066-i2s", },
	{},
};

The spi of rk3399 as same as rk3066, rk3188, rk3288, like i2s, if they 
are keep different rules ?


>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
>
