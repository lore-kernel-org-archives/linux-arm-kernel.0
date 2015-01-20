From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Jan 2015 15:35:29 +0800
Subject: [PATCH 1/2] ARM: imx6sx-sdb: change default board as reva board
In-Reply-To: <1421220998-3491-2-git-send-email-peter.chen@freescale.com>
References: <1421220998-3491-1-git-send-email-peter.chen@freescale.com>
 <1421220998-3491-2-git-send-email-peter.chen@freescale.com>
Message-ID: <20150120073527.GT2766@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 03:36:37PM +0800, Peter Chen wrote:
> The imx6sx sdb board has two revisions, the current mainline one
> is reva which is mainly for internal use. In this commit, we
> rename imx6sx-sdb.dts to imx6sx-sdb.dtsi, and move the reva dedicated
> contents to imx6sx-sdb-reva.dts.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb-reva.dts              | 158 +++++++++++++++++++++
>  .../boot/dts/{imx6sx-sdb.dts => imx6sx-sdb.dtsi}   | 131 -----------------

arch/arm/boot/dts/Makefile needs an update.

>  2 files changed, 158 insertions(+), 131 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6sx-sdb-reva.dts
>  rename arch/arm/boot/dts/{imx6sx-sdb.dts => imx6sx-sdb.dtsi} (83%)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> new file mode 100644
> index 0000000..e7a8c34
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> @@ -0,0 +1,158 @@
> +/*
> + * Copyright (C) 2014-2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "imx6sx-sdb.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX6 SoloX SDB RevA Board";
> +};
> +
> +&cpu0 {
> +	operating-points = <
> +		/* kHz    uV */
> +		996000  1250000
> +		792000  1175000
> +		396000  1075000
> +	>;
> +	fsl,soc-operating-points = <
> +		/* ARM kHz  SOC uV */
> +		996000      1175000
> +		792000      1175000
> +		396000      1175000
> +	>;

I'm wondering why different revision of the board require a different
OPP settings.

Shawn

> +};
> +
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
> +				regulator-always-on;
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
> +				regulator-always-on;
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
> +&qspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_qspi2>;
> +	status = "okay";
> +
> +	flash0: s25fl128s at 0 {
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "spansion,s25fl128s";
> +		spi-max-frequency = <66000000>;
> +	};
> +
> +	flash1: s25fl128s at 1 {
> +		reg = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "spansion,s25fl128s";
> +		spi-max-frequency = <66000000>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dtsi
> similarity index 83%
> rename from arch/arm/boot/dts/imx6sx-sdb.dts
> rename to arch/arm/boot/dts/imx6sx-sdb.dtsi
> index cdffe84..7b02aa7 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
> @@ -13,7 +13,6 @@
>  #include "imx6sx.dtsi"
>  
>  / {
> -	model = "Freescale i.MX6 SoloX SDB Board";
>  	compatible = "fsl,imx6sx-sdb", "fsl,imx6sx";
>  
>  	chosen {
> @@ -169,114 +168,6 @@
>  	status = "okay";
>  };
>  
> -&i2c1 {
> -        clock-frequency = <100000>;
> -        pinctrl-names = "default";
> -        pinctrl-0 = <&pinctrl_i2c1>;
> -        status = "okay";
> -
> -	pmic: pfuze100 at 08 {
> -		compatible = "fsl,pfuze100";
> -		reg = <0x08>;
> -
> -		regulators {
> -			sw1a_reg: sw1ab {
> -				regulator-min-microvolt = <300000>;
> -				regulator-max-microvolt = <1875000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -				regulator-ramp-delay = <6250>;
> -			};
> -
> -			sw1c_reg: sw1c {
> -				regulator-min-microvolt = <300000>;
> -				regulator-max-microvolt = <1875000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -				regulator-ramp-delay = <6250>;
> -			};
> -
> -			sw2_reg: sw2 {
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			sw3a_reg: sw3a {
> -				regulator-min-microvolt = <400000>;
> -				regulator-max-microvolt = <1975000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			sw3b_reg: sw3b {
> -				regulator-min-microvolt = <400000>;
> -				regulator-max-microvolt = <1975000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			sw4_reg: sw4 {
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <3300000>;
> -			};
> -
> -			swbst_reg: swbst {
> -				regulator-min-microvolt = <5000000>;
> -				regulator-max-microvolt = <5150000>;
> -			};
> -
> -			snvs_reg: vsnvs {
> -				regulator-min-microvolt = <1000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			vref_reg: vrefddr {
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			vgen1_reg: vgen1 {
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <1550000>;
> -				regulator-always-on;
> -			};
> -
> -			vgen2_reg: vgen2 {
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <1550000>;
> -			};
> -
> -			vgen3_reg: vgen3 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			vgen4_reg: vgen4 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			vgen5_reg: vgen5 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			vgen6_reg: vgen6 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -		};
> -	};
> -};
> -
>  &i2c4 {
>          clock-frequency = <100000>;
>          pinctrl-names = "default";
> @@ -340,28 +231,6 @@
>  	status = "okay";
>  };
>  
> -&qspi2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_qspi2>;
> -	status = "okay";
> -
> -	flash0: s25fl128s at 0 {
> -		reg = <0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "spansion,s25fl128s";
> -		spi-max-frequency = <66000000>;
> -	};
> -
> -	flash1: s25fl128s at 1 {
> -		reg = <1>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "spansion,s25fl128s";
> -		spi-max-frequency = <66000000>;
> -	};
> -};
> -
>  &ssi2 {
>  	status = "okay";
>  };
> -- 
> 1.9.1
> 
