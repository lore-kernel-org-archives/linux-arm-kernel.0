From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 30 Mar 2013 11:32:18 +0100
Subject: [PATCH 1/2] ARM: imx27: Add PWM0 to device tree
In-Reply-To: <1364545419-21558-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1364545419-21558-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20130330103218.GU1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 09:23:38AM +0100, Gwenhael Goavec-Merou wrote:
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> ---
>  arch/arm/boot/dts/imx27.dtsip | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsip b/arch/arm/boot/dts/imx27.dtsip
> index ff4bd48..d4196d1 100644
> --- a/arch/arm/boot/dts/imx27.dtsip
> +++ b/arch/arm/boot/dts/imx27.dtsip
> @@ -89,6 +89,15 @@
>  				clock-names = "ipg", "per";
>  			};
>  
> +			pwm0: pwm at 10006000 {
> +				compatible = "fsl,imx27-pwm";
> +				reg = <0x10006000 0x1000>;
> +				interrupts = <23>;
> +				clocks = <&clks 34>, <&clks 61>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};

A pwm does not do anything on its own when it's not being used as
backlight, led or something else. So I wonder if it's worth it adding
status = "disabled"; here. Also, what's the result of enabling it in
your board like in patch 2/2? I suppose nothing will happen, right?

Sascha

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
