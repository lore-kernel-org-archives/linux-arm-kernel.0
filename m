From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 Oct 2013 10:24:13 +0200
Subject: [PATCH] ARM: imx27: add missing #pwm-cells property
In-Reply-To: <1382014996-18084-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1382014996-18084-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20131018082413.GY30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 03:03:16PM +0200, Steffen Trumtrar wrote:
> The pwm-node is missing its #pwm-cells property. The pwm-framework will
> complain about this.
> 
> Add the missing property.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  arch/arm/boot/dts/imx27.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index b7a1c6d..826231e 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -123,6 +123,7 @@
>  			};
>  
>  			pwm: pwm at 10006000 {
> +				#pwm-cells = <2>;
>  				compatible = "fsl,imx27-pwm";
>  				reg = <0x10006000 0x1000>;
>  				interrupts = <23>;
> -- 
> 1.8.4.rc3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
