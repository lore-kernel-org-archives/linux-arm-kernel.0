From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 10 Apr 2014 10:51:09 +0200
Subject: [PATCH] mx-drm: imx-tve: correct DDC property name to
 'ddc-i2c-bus'
In-Reply-To: <1397110745-15731-1-git-send-email-shawn.guo@freescale.com>
References: <1397110745-15731-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1397119869.3226.8.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 10.04.2014, 14:19 +0800 schrieb Shawn Guo:
> Commit 62e3879 (imx-drm: imx-tve: Fix DDC I2C bus property) was trying
> to use 'ddc-i2c-bus' as the DDC property name (we can see that from the
> commit log), but unfortunately 'i2c-ddc-bus' which is a typo was
> actually used in the code.  This results in some unnecessary
> inconsistency and confusions, because all the documented DDC property
> in device tree bindings use 'ddc-i2c-bus'.
> 
>   Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
>   Documentation/devicetree/bindings/panel/simple-panel.txt
>   Documentation/devicetree/bindings/video/dvi-connector.txt
> 
> Let's fix it before the error spreads.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/boot/dts/imx53-mba53.dts | 2 +-
>  drivers/staging/imx-drm/imx-tve.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
> index 7c8c129..a3431d7 100644
> --- a/arch/arm/boot/dts/imx53-mba53.dts
> +++ b/arch/arm/boot/dts/imx53-mba53.dts
> @@ -244,7 +244,7 @@
>  &tve {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_vga_sync_1>;
> -	i2c-ddc-bus = <&i2c3>;
> +	ddc-i2c-bus = <&i2c3>;
>  	fsl,tve-mode = "vga";
>  	fsl,hsync-pin = <4>;
>  	fsl,vsync-pin = <6>;
> diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
> index 575533f..a23f4f7 100644
> --- a/drivers/staging/imx-drm/imx-tve.c
> +++ b/drivers/staging/imx-drm/imx-tve.c
> @@ -582,7 +582,7 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
>  	tve->dev = dev;
>  	spin_lock_init(&tve->lock);
>  
> -	ddc_node = of_parse_phandle(np, "i2c-ddc-bus", 0);
> +	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
>  	if (ddc_node) {
>  		tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
>  		of_node_put(ddc_node);

Ouch, sorry.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
