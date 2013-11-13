From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Nov 2013 22:41:41 +0800
Subject: [PATCH v7 3/7] ARM: dts: imx27 pinctrl
In-Reply-To: <1384246210-9257-4-git-send-email-mpa@pengutronix.de>
References: <1384246210-9257-1-git-send-email-mpa@pengutronix.de>
 <1384246210-9257-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20131113144139.GB17816@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 09:50:06AM +0100, Markus Pargmann wrote:
> Pinctrl driver node and pin group definitions for other driver nodes.

Neither patch subject nor commit log is telling anything useful, like
what is the change and why the changes.

Shawn

> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx27.dtsi | 125 +++++++++++++++++++++++--------------------
>  1 file changed, 67 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index b7a1c6d..f119296 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -10,6 +10,7 @@
>   */
>  
>  #include "skeleton.dtsi"
> +#include "imx27-pingrp.h"
>  
>  / {
>  	aliases {
> @@ -235,64 +236,72 @@
>  				status = "disabled";
>  			};
>  
> -			gpio1: gpio at 10015000 {
> -				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> -				reg = <0x10015000 0x100>;
> -				interrupts = <8>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpio2: gpio at 10015100 {
> -				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> -				reg = <0x10015100 0x100>;
> -				interrupts = <8>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpio3: gpio at 10015200 {
> -				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> -				reg = <0x10015200 0x100>;
> -				interrupts = <8>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpio4: gpio at 10015300 {
> -				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> -				reg = <0x10015300 0x100>;
> -				interrupts = <8>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpio5: gpio at 10015400 {
> -				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> -				reg = <0x10015400 0x100>;
> -				interrupts = <8>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpio6: gpio at 10015500 {
> -				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> -				reg = <0x10015500 0x100>;
> -				interrupts = <8>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> +			iomuxc: iomuxc at 10015000 {
> +				compatible = "fsl,imx27-iomuxc";
> +				reg = <0x10015000 0x600>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges;
> +
> +				gpio1: gpio at 10015000 {
> +					compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> +					reg = <0x10015000 0x100>;
> +					interrupts = <8>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +				};
> +
> +				gpio2: gpio at 10015100 {
> +					compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> +					reg = <0x10015100 0x100>;
> +					interrupts = <8>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +				};
> +
> +				gpio3: gpio at 10015200 {
> +					compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> +					reg = <0x10015200 0x100>;
> +					interrupts = <8>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +				};
> +
> +				gpio4: gpio at 10015300 {
> +					compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> +					reg = <0x10015300 0x100>;
> +					interrupts = <8>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +				};
> +
> +				gpio5: gpio at 10015400 {
> +					compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> +					reg = <0x10015400 0x100>;
> +					interrupts = <8>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +				};
> +
> +				gpio6: gpio at 10015500 {
> +					compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
> +					reg = <0x10015500 0x100>;
> +					interrupts = <8>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +				};
>  			};
>  
>  			audmux: audmux at 10016000 {
> -- 
> 1.8.4.2
> 
