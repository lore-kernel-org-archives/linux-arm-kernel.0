From: atull@kernel.org (Alan Tull)
Date: Sun, 18 Dec 2016 20:23:47 -0600 (CST)
Subject: [PATCH v6 5/5] ARM: dts: imx6q-evi: support cyclone-ps-spi
In-Reply-To: <26327c58cbf5acd8078c50e87d23293c80ee89a2.1481918884.git.stillcompiling@gmail.com>
References: <cover.1481918884.git.stillcompiling@gmail.com>
 <26327c58cbf5acd8078c50e87d23293c80ee89a2.1481918884.git.stillcompiling@gmail.com>
Message-ID: <alpine.DEB.2.10.1612182023220.2528@atull-730U3E-740U3E>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Dec 2016, Joshua Clayton wrote:

> Add support for Altera cyclone V FPGA connected to an spi port
> to the evi devicetree file
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>

Acked-by: Alan Tull <atull@opensource.altera.com>

> ---
>  arch/arm/boot/dts/imx6q-evi.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
> index 7c7c1a8..ec4d365 100644
> --- a/arch/arm/boot/dts/imx6q-evi.dts
> +++ b/arch/arm/boot/dts/imx6q-evi.dts
> @@ -95,6 +95,15 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1cs>;
>  	status = "okay";
> +
> +	fpga_spi: cyclonespi at 0 {
> +		compatible = "altr,cyclone-ps-spi-fpga-mgr";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +		pinctrl-0 = <&pinctrl_fpgaspi>;
> +		config-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
> +		status-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  &ecspi3 {
> @@ -322,6 +331,13 @@
>  		>;
>  	};
>  
> +	pinctrl_fpgaspi: fpgaspigrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_ROW1__GPIO4_IO09 0x1b0b0
> +			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11 0x1b0b0
> +		>;
> +	};
> +
>  	pinctrl_gpminand: gpminandgrp {
>  		fsl,pins = <
>  			MX6QDL_PAD_NANDF_CLE__NAND_CLE 0xb0b1
> -- 
> 2.9.3
> 
> 
