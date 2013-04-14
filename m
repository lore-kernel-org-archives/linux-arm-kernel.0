From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 14 Apr 2013 10:49:27 +0200
Subject: [PATCH v2] ARM: imx27: Add PWM0 to device tree
In-Reply-To: <1365925465-17453-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1365925465-17453-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20130414084927.GA1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 14, 2013 at 09:44:25AM +0200, Gwenhael Goavec-Merou wrote:
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
> v2:
> - Suppress status, now PWM is always enabled;
> - Suppress platform patch.
> 
>  arch/arm/boot/dts/imx27.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index ff4bd48..14e97cf 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -89,6 +89,14 @@
>  				clock-names = "ipg", "per";
>  			};
>  
> +			pwm0: pwm at 10006000 {
> +				compatible = "fsl,imx27-pwm";
> +				reg = <0x10006000 0x1000>;
> +				interrupts = <23>;
> +				clocks = <&clks 34>, <&clks 61>;
> +				clock-names = "ipg", "per";
> +			};
> +
>  			uart1: serial at 1000a000 {
>  				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
>  				reg = <0x1000a000 0x1000>;
> -- 
> 1.8.1.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
