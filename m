From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 May 2015 15:39:05 +0800
Subject: [PATCH v4 6/6] arm: dts: imx6sx: enable snvs power key
In-Reply-To: <1432305399-30571-7-git-send-email-Frank.Li@freescale.com>
References: <1432305399-30571-1-git-send-email-Frank.Li@freescale.com>
 <1432305399-30571-7-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150525073904.GJ3264@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 10:36:39PM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> enable snvs ONOFF power key support
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Please use 'ARM: dts: imx6sx: ...' for the patch subject.

> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 3cb3b5b..ad38aea 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -677,6 +677,13 @@
>  					mask = <0x60>;
>  					status = "disabled";
>  				};
> +
> +				snvs_pwrkey: snvs-powerkey {
> +					compatible = "fsl,sec-v4.0-pwrkey";
> +					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +					linux,keycode = <116>; /* KEY_POWER */

With include/dt-bindings/input/input.h, you can use KEY_POWER directly
and save the comment.

Shawn

> +					wakeup;
> +				};
>  			};
>  
>  			epit1: epit at 020d0000 {
> -- 
> 1.9.1
> 
