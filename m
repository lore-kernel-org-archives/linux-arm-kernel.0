From: marex@denx.de (Marek Vasut)
Date: Fri, 15 Jun 2012 13:47:43 +0200
Subject: [PATCH v2 1/3] ARM: dts: mx28evk: Add auart0 and auart3 support
In-Reply-To: <1339759950-5507-1-git-send-email-festevam@gmail.com>
References: <1339759950-5507-1-git-send-email-festevam@gmail.com>
Message-ID: <201206151347.43333.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add auart0 and auart3 support.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Marek Vasut <marex@denx.de>

> ---
> Changes since v1:
> - Merged patches 1 and 2 from v1 into this one
>  arch/arm/boot/dts/imx28-evk.dts |   12 ++++++++++++
>  arch/arm/boot/dts/imx28.dtsi    |   26 ++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-evk.dts
> b/arch/arm/boot/dts/imx28-evk.dts index ee520a5..4353f48 100644
> --- a/arch/arm/boot/dts/imx28-evk.dts
> +++ b/arch/arm/boot/dts/imx28-evk.dts
> @@ -73,6 +73,18 @@
>  				pinctrl-0 = <&duart_pins_a>;
>  				status = "okay";
>  			};
> +
> +			auart0: serial at 8006a000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&auart0_pins_a>;
> +				status = "okay";
> +			};
> +
> +			auart3: serial at 80070000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&auart3_pins_a>;
> +				status = "okay";
> +			};
>  		};
>  	};
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 4634cb8..f26e0d6 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -22,6 +22,11 @@
>  		gpio4 = &gpio4;
>  		saif0 = &saif0;
>  		saif1 = &saif1;
> +		serial0 = &auart0;
> +		serial1 = &auart1;
> +		serial2 = &auart2;
> +		serial3 = &auart3;
> +		serial4 = &auart4;
>  	};
> 
>  	cpus {
> @@ -167,6 +172,22 @@
>  					fsl,pull-up = <0>;
>  				};
> 
> +				auart0_pins_a: auart0 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x3000 0x3010 0x3020 
0x3030>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +
> +				auart3_pins_a: auart3 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x30c0 0x30d0 0x30e0 
0x30f0>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +
>  				mac0_pins_a: mac0 at 0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <0x4000 0x4010 0x4020
> @@ -404,30 +425,35 @@
>  			};
> 
>  			auart0: serial at 8006a000 {
> +				compatible = "fsl,mxs-auart";
>  				reg = <0x8006a000 0x2000>;
>  				interrupts = <112 70 71>;
>  				status = "disabled";
>  			};
> 
>  			auart1: serial at 8006c000 {
> +				compatible = "fsl,mxs-auart";
>  				reg = <0x8006c000 0x2000>;
>  				interrupts = <113 72 73>;
>  				status = "disabled";
>  			};
> 
>  			auart2: serial at 8006e000 {
> +				compatible = "fsl,mxs-auart";
>  				reg = <0x8006e000 0x2000>;
>  				interrupts = <114 74 75>;
>  				status = "disabled";
>  			};
> 
>  			auart3: serial at 80070000 {
> +				compatible = "fsl,mxs-auart";
>  				reg = <0x80070000 0x2000>;
>  				interrupts = <115 76 77>;
>  				status = "disabled";
>  			};
> 
>  			auart4: serial at 80072000 {
> +				compatible = "fsl,mxs-auart";
>  				reg = <0x80072000 0x2000>;
>  				interrupts = <116 78 79>;
>  				status = "disabled";

Best regards,
Marek Vasut
