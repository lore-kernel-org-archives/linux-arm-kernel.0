From: jun.gao@mediatek.com (Jun Gao)
Date: Mon, 12 Jun 2017 19:54:28 +0800
Subject: [PATCH v4 2/2] arm: dts: Add Mediatek MT2701 i2c device node
In-Reply-To: <1495784107-6711-3-git-send-email-jun.gao@mediatek.com>
References: <1495784107-6711-1-git-send-email-jun.gao@mediatek.com>
 <1495784107-6711-3-git-send-email-jun.gao@mediatek.com>
Message-ID: <1497268468.930.26.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-05-26 at 15:35 +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add MT2701 i2c device node.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> ---
>  arch/arm/boot/dts/mt2701-evb.dts | 42 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/mt2701.dtsi    | 42 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
> index a483798..3f5a96c 100644
> --- a/arch/arm/boot/dts/mt2701-evb.dts
> +++ b/arch/arm/boot/dts/mt2701-evb.dts
> @@ -28,7 +28,49 @@
>  	status = "okay";
>  };
>  
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins_a>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins_a>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins_a>;
> +	status = "okay";
> +};
> +
>  &pio {
> +	i2c0_pins_a: i2c0 at 0 {
> +		pins1 {
> +			pinmux = <MT2701_PIN_75_SDA0__FUNC_SDA0>,
> +				 <MT2701_PIN_76_SCL0__FUNC_SCL0>;
> +			bias-disable;
> +		};
> +	};
> +
> +	i2c1_pins_a: i2c1 at 0 {
> +		pins1 {
> +			pinmux = <MT2701_PIN_57_SDA1__FUNC_SDA1>,
> +				 <MT2701_PIN_58_SCL1__FUNC_SCL1>;
> +			bias-disable;
> +		};
> +	};
> +
> +	i2c2_pins_a: i2c2 at 0 {
> +		pins1 {
> +			pinmux = <MT2701_PIN_77_SDA2__FUNC_SDA2>,
> +				 <MT2701_PIN_78_SCL2__FUNC_SCL2>;
> +			bias-disable;
> +		};
> +	};
> +
>  	spi_pins_a: spi0 at 0 {
>  		pins_spi {
>  			pinmux = <MT2701_PIN_53_SPI0_CSN__FUNC_SPI0_CS>,
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 8037210..1b6157e 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -286,6 +286,48 @@
>  		status = "disabled";
>  	};
>  
> +	i2c0: i2c at 11007000 {
> +		compatible = "mediatek,mt2701-i2c",
> +			     "mediatek,mt6577-i2c";
> +		reg = <0 0x11007000 0 0x70>,
> +		      <0 0x11000200 0 0x80>;
> +		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
> +		clock-div = <16>;
> +		clocks = <&pericfg CLK_PERI_I2C0>, <&pericfg CLK_PERI_AP_DMA>;
> +		clock-names = "main", "dma";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	i2c1: i2c at 11008000 {
> +		compatible = "mediatek,mt2701-i2c",
> +			     "mediatek,mt6577-i2c";
> +		reg = <0 0x11008000 0 0x70>,
> +		      <0 0x11000280 0 0x80>;
> +		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_LOW>;
> +		clock-div = <16>;
> +		clocks = <&pericfg CLK_PERI_I2C1>, <&pericfg CLK_PERI_AP_DMA>;
> +		clock-names = "main", "dma";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	i2c2: i2c at 11009000 {
> +		compatible = "mediatek,mt2701-i2c",
> +			     "mediatek,mt6577-i2c";
> +		reg = <0 0x11009000 0 0x70>,
> +		      <0 0x11000300 0 0x80>;
> +		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_LOW>;
> +		clock-div = <16>;
> +		clocks = <&pericfg CLK_PERI_I2C2>, <&pericfg CLK_PERI_AP_DMA>;
> +		clock-names = "main", "dma";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	spi0: spi at 1100a000 {
>  		compatible = "mediatek,mt2701-spi";
>  		#address-cells = <1>;

Dear Matthias,

Could you take this patch together with 
[PATCH v4 1/2]dt-bindings: i2c: Add Mediatek MT2701 i2c binding ?

Thanks!
