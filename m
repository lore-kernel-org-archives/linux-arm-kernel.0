From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 7 Jan 2013 18:12:24 +0100
Subject: [PATCH] ARM: mx5: Fix MX53 flexcan2 clock
In-Reply-To: <1357568820-15426-1-git-send-email-marex@denx.de>
References: <1357568820-15426-1-git-send-email-marex@denx.de>
Message-ID: <20130107171224.GA13025@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 03:27:00PM +0100, Marek Vasut wrote:
> The second FlexCAN port uses different clock than the first one, configure
> correct clock to prevent hanging of the system during bringing up of the port.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Looks Good.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  arch/arm/boot/dts/imx53.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 5b59763..abe0f0b 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -614,7 +614,7 @@
>  				compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
>  				reg = <0x53fcc000 0x4000>;
>  				interrupts = <83>;
> -				clocks = <&clks 158>, <&clks 157>;
> +				clocks = <&clks 87>, <&clks 86>;
>  				clock-names = "ipg", "per";
>  				status = "disabled";
>  			};
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
