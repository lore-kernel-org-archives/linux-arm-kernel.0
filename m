From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Jan 2014 20:08:00 +0800
Subject: [PATCH 1/2] ARM: dts: imx6sl-evk: Add PFUZE100 support
In-Reply-To: <1390443213-14061-1-git-send-email-festevam@gmail.com>
References: <1390443213-14061-1-git-send-email-festevam@gmail.com>
Message-ID: <20140128120759.GJ20583@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 12:13:32AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx6sl-evk board has Freescale PFUZE100 regulator, so add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6sl-evk.dts  | 110 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6sl-pingrp.h |   4 ++
>  2 files changed, 114 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
> index f23b5d1..5ba15ab 100644
> --- a/arch/arm/boot/dts/imx6sl-evk.dts
> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> @@ -46,6 +46,112 @@
>  	};
>  };
>  
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic: pfuze100 at 08 {
> +		compatible = "fsl,pfuze100";
> +		reg = <0x08>;
> +
> +		regulators {
> +			sw1a_reg: sw1ab {
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1875000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <6250>;
> +			};
> +
> +			sw1c_reg: sw1c {
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1875000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <6250>;
> +			};
> +
> +			sw2_reg: sw2 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3a_reg: sw3a {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1975000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3b_reg: sw3b {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1975000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw4_reg: sw4 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			swbst_reg: swbst {
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5150000>;
> +			};
> +
> +			snvs_reg: vsnvs {
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vref_reg: vrefddr {
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vgen1_reg: vgen1 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vgen2_reg: vgen2 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vgen3_reg: vgen3 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			vgen4_reg: vgen4 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen5_reg: vgen5 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen6_reg: vgen6 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
>  &ecspi1 {
>  	fsl,spi-num-chipselects = <1>;
>  	cs-gpios = <&gpio4 11 0>;
> @@ -86,6 +192,10 @@
>  			>;
>  		};
>  
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <MX6SL_I2C1_PINGRP1>;
> +		};
> +
>  		pinctrl_ecspi1: ecspi1grp {
>  			fsl,pins = <MX6SL_ECSPI1_PINGRP1>;
>  		};
> diff --git a/arch/arm/boot/dts/imx6sl-pingrp.h b/arch/arm/boot/dts/imx6sl-pingrp.h
> index ead26d4..cada37a 100644
> --- a/arch/arm/boot/dts/imx6sl-pingrp.h
> +++ b/arch/arm/boot/dts/imx6sl-pingrp.h
> @@ -15,6 +15,10 @@
>  	MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI		0x100b1 \
>  	MX6SL_PAD_ECSPI1_SCLK__ECSPI1_SCLK		0x100b1
>  
> +#define MX6SL_I2C1_PINGRP1 \
> +	MX6SL_PAD_I2C1_SCL__I2C1_SCL			0x4001b8b1 \
> +	MX6SL_PAD_I2C1_SDA__I2C1_SDA			0x4001b8b1
> +

The PINGRP is gone.

Shawn

>  #define MX6SL_FEC_PINGRP1 \
>  	MX6SL_PAD_FEC_MDC__FEC_MDC			0x1b0b0 \
>  	MX6SL_PAD_FEC_MDIO__FEC_MDIO			0x1b0b0 \
> -- 
> 1.8.1.2
> 
