From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 1 Feb 2017 15:02:53 +0000
Subject: [STLinux Kernel] [PATCH v2 09/10] ARM: dts: STiH407-family: Use
 new Pinctrl groups
In-Reply-To: <20170201143145.31962-10-lee.jones@linaro.org>
References: <20170201143145.31962-1-lee.jones@linaro.org>
 <20170201143145.31962-10-lee.jones@linaro.org>
Message-ID: <20170201150253.GF28760@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 01 Feb 2017, Lee Jones wrote:

> Having just defined some new Pinctrl groups for when HW flow-control
> is {en,dis}abled, let's reference them for use within the driver.

Acked-by: Peter Griffin <peter.griffin@linaro.org>

> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 3 +--
>  arch/arm/boot/dts/stih410-b2260.dts   | 5 ++++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index c8b2944..e480e32 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -222,9 +222,8 @@
>  			compatible = "st,asc";
>  			reg = <0x9830000 0x2c>;
>  			interrupts = <GIC_SPI 122 IRQ_TYPE_NONE>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&pinctrl_serial0>;
>  			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			/* Pinctrl moved out to a per-board configuration */
>  
>  			status = "disabled";
>  		};
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index fa16aba..cbcbcb4 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -62,8 +62,11 @@
>  		/* Low speed expansion connector */
>  		uart0: serial at 9830000 {
>  			label = "LS-UART0";
> -			status = "okay";
> +			pinctrl-names = "default", "no-hw-flowctrl";
> +			pinctrl-0 = <&pinctrl_serial0_hw_flowctrl>;
> +			pinctrl-1 = <&pinctrl_serial0>;
>  			rts-gpios = <&pio17 3 GPIO_ACTIVE_LOW>;
> +			status = "okay";
>  		};
>  
>  		/* Low speed expansion connector */
