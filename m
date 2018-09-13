From: stefan@agner.ch (Stefan Agner)
Date: Thu, 13 Sep 2018 13:10:37 -0700
Subject: [PATCH] ARM: dts: fsl: Fix SPI bus warnings
In-Reply-To: <20180913181245.25484-5-robh@kernel.org>
References: <20180913181245.25484-5-robh@kernel.org>
Message-ID: <1de6e24508a964e826b29ba4294b26ae@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.09.2018 11:12, Rob Herring wrote:
> dtc has new checks for SPI buses. Fix the warnings in node names and
> unit-addresses.
> 
> There's over 100 warnings for FSL boards, a few examples:
> 
> arch/arm/boot/dts/imx28-duckbill-2-spi.dtb: Warning (spi_bus_bridge): /apb at 80000000/apbh at 80000000/ssp at 80014000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/imx53-ppd.dtb: Warning (spi_bus_bridge): /soc/aips at 50000000/spba at 50000000/ecspi at 50010000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb: Warning (spi_bus_reg): /soc/aips-bus at 2000000/spba-bus at 2000000/spi at 2014000/mcp251x at 1: SPI bus unit address format error, expected "0"
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Rob Herring <robh@kernel.org>

Looks good to me.

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but 
> will for 4.20.
> 
>  arch/arm/boot/dts/imx1.dtsi                    |  4 ++--
>  arch/arm/boot/dts/imx23-evk.dts                |  2 +-
>  arch/arm/boot/dts/imx23-olinuxino.dts          |  4 ++--
>  arch/arm/boot/dts/imx23-sansa.dts              |  4 ++--
>  arch/arm/boot/dts/imx23-stmp378x_devb.dts      |  2 +-
>  arch/arm/boot/dts/imx23-xfi3.dts               |  4 ++--
>  arch/arm/boot/dts/imx23.dtsi                   |  4 ++--
>  arch/arm/boot/dts/imx25.dtsi                   |  6 +++---
>  arch/arm/boot/dts/imx27.dtsi                   |  6 +++---
>  arch/arm/boot/dts/imx28-apf28dev.dts           |  4 ++--
>  arch/arm/boot/dts/imx28-apx4devkit.dts         |  4 ++--
>  arch/arm/boot/dts/imx28-cfa10036.dts           |  2 +-
>  arch/arm/boot/dts/imx28-duckbill-2-485.dts     |  4 ++--
>  arch/arm/boot/dts/imx28-duckbill-2-enocean.dts |  4 ++--
>  arch/arm/boot/dts/imx28-duckbill-2-spi.dts     |  4 ++--
>  arch/arm/boot/dts/imx28-duckbill-2.dts         |  4 ++--
>  arch/arm/boot/dts/imx28-duckbill.dts           |  4 ++--
>  arch/arm/boot/dts/imx28-evk.dts                |  6 +++---
>  arch/arm/boot/dts/imx28-m28cu3.dts             |  4 ++--
>  arch/arm/boot/dts/imx28-m28evk.dts             |  4 ++--
>  arch/arm/boot/dts/imx28-sps1.dts               |  4 ++--
>  arch/arm/boot/dts/imx28-ts4600.dts             |  2 +-
>  arch/arm/boot/dts/imx28.dtsi                   |  8 ++++----
>  arch/arm/boot/dts/imx31.dtsi                   |  4 ++--
>  arch/arm/boot/dts/imx35.dtsi                   |  4 ++--
>  arch/arm/boot/dts/imx50.dtsi                   |  6 +++---
>  arch/arm/boot/dts/imx51.dtsi                   |  6 +++---
>  arch/arm/boot/dts/imx53.dtsi                   |  6 +++---
>  arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts   |  2 +-
>  arch/arm/boot/dts/imx6q.dtsi                   |  2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                 |  8 ++++----
>  arch/arm/boot/dts/imx6sl.dtsi                  |  8 ++++----
>  arch/arm/boot/dts/imx6sx.dtsi                  | 14 +++++++-------
>  arch/arm/boot/dts/imx6ul.dtsi                  | 10 +++++-----
>  arch/arm/boot/dts/imx7s.dtsi                   |  8 ++++----
>  arch/arm/boot/dts/ls1021a.dtsi                 |  6 +++---
>  arch/arm/boot/dts/vfxxx.dtsi                   | 12 ++++++------
>  37 files changed, 95 insertions(+), 95 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
> index 3edc7b5550d8..b00ece16b853 100644
> --- a/arch/arm/boot/dts/imx1.dtsi
> +++ b/arch/arm/boot/dts/imx1.dtsi
> @@ -164,7 +164,7 @@
>  			reg = <0x00210000 0x10000>;
>  			ranges;
>  
> -			cspi1: cspi at 213000 {
> +			cspi1: spi at 213000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx1-cspi";
> @@ -186,7 +186,7 @@
>  				status = "disabled";
>  			};
>  
> -			cspi2: cspi at 219000 {
> +			cspi2: spi at 219000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx1-cspi";
> diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
> index ad2ae25b7b4d..98efe1aeb26a 100644
> --- a/arch/arm/boot/dts/imx23-evk.dts
> +++ b/arch/arm/boot/dts/imx23-evk.dts
> @@ -58,7 +58,7 @@
>  				status = "okay";
>  			};
>  
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx23-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
> diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
> index e9351774c619..31b1e3581ac0 100644
> --- a/arch/arm/boot/dts/imx23-olinuxino.dts
> +++ b/arch/arm/boot/dts/imx23-olinuxino.dts
> @@ -25,7 +25,7 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx23-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
> @@ -59,7 +59,7 @@
>  				};
>  			};
>  
> -			ssp1: ssp at 80034000 {
> +			ssp1: spi at 80034000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx23-spi";
> diff --git a/arch/arm/boot/dts/imx23-sansa.dts b/arch/arm/boot/dts/imx23-sansa.dts
> index 67de7863ad79..faf701b2adb2 100644
> --- a/arch/arm/boot/dts/imx23-sansa.dts
> +++ b/arch/arm/boot/dts/imx23-sansa.dts
> @@ -55,7 +55,7 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx23-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
> @@ -65,7 +65,7 @@
>  				status = "okay";
>  			};
>  
> -			ssp1: ssp at 80034000 {
> +			ssp1: spi at 80034000 {
>  				compatible = "fsl,imx23-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc1_8bit_pins_a>;
> diff --git a/arch/arm/boot/dts/imx23-stmp378x_devb.dts b/arch/arm/boot/dts/imx23-stmp378x_devb.dts
> index 95c7b918f6d6..2ff6cdf71a55 100644
> --- a/arch/arm/boot/dts/imx23-stmp378x_devb.dts
> +++ b/arch/arm/boot/dts/imx23-stmp378x_devb.dts
> @@ -22,7 +22,7 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx23-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
> diff --git a/arch/arm/boot/dts/imx23-xfi3.dts b/arch/arm/boot/dts/imx23-xfi3.dts
> index 9616e500b996..db53089fb7fb 100644
> --- a/arch/arm/boot/dts/imx23-xfi3.dts
> +++ b/arch/arm/boot/dts/imx23-xfi3.dts
> @@ -54,7 +54,7 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx23-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
> @@ -64,7 +64,7 @@
>  				status = "okay";
>  			};
>  
> -			ssp1: ssp at 80034000 {
> +			ssp1: spi at 80034000 {
>  				compatible = "fsl,imx23-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc1_4bit_pins_a>;
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index 71bfd2b15609..ea259927eef6 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -93,7 +93,7 @@
>  				status = "disabled";
>  			};
>  
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				reg = <0x80010000 0x2000>;
>  				interrupts = <15>;
>  				clocks = <&clks 33>;
> @@ -457,7 +457,7 @@
>  				status = "disabled";
>  			};
>  
> -			ssp1: ssp at 80034000 {
> +			ssp1: spi at 80034000 {
>  				reg = <0x80034000 0x2000>;
>  				interrupts = <2>;
>  				clocks = <&clks 33>;
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index 85c15ee63272..b25309d26ea5 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -168,7 +168,7 @@
>  				status = "disabled";
>  			};
>  
> -			spi1: cspi at 43fa4000 {
> +			spi1: spi at 43fa4000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
> @@ -209,7 +209,7 @@
>  			reg = <0x50000000 0x40000>;
>  			ranges;
>  
> -			spi3: cspi at 50004000 {
> +			spi3: spi at 50004000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
> @@ -238,7 +238,7 @@
>  				status = "disabled";
>  			};
>  
> -			spi2: cspi at 50010000 {
> +			spi2: spi at 50010000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 753d88df1627..151b0eb17dda 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -209,7 +209,7 @@
>  				status = "disabled";
>  			};
>  
> -			cspi1: cspi at 1000e000 {
> +			cspi1: spi at 1000e000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx27-cspi";
> @@ -221,7 +221,7 @@
>  				status = "disabled";
>  			};
>  
> -			cspi2: cspi at 1000f000 {
> +			cspi2: spi at 1000f000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx27-cspi";
> @@ -373,7 +373,7 @@
>  				status = "disabled";
>  			};
>  
> -			cspi3: cspi at 10017000 {
> +			cspi3: spi at 10017000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx27-cspi";
> diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
> index c4fadbc1b400..8df5ec470376 100644
> --- a/arch/arm/boot/dts/imx28-apf28dev.dts
> +++ b/arch/arm/boot/dts/imx28-apf28dev.dts
> @@ -18,7 +18,7 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a
> @@ -27,7 +27,7 @@
>  				status = "okay";
>  			};
>  
> -			ssp2: ssp at 80014000 {
> +			ssp2: spi at 80014000 {
>  				compatible = "fsl,imx28-spi";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&spi2_pins_a>;
> diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
> index 96faa53ba44c..6c9b498305c0 100644
> --- a/arch/arm/boot/dts/imx28-apx4devkit.dts
> +++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
> @@ -18,7 +18,7 @@
>  				status = "okay";
>  			};
>  
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_sck_cfg>;
> @@ -26,7 +26,7 @@
>  				status = "okay";
>  			};
>  
> -			ssp2: ssp at 80014000 {
> +			ssp2: spi at 80014000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc2_4bit_pins_apx4 &mmc2_sck_cfg_apx4>;
> diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
> index e54f5aba7091..8337ca21e281 100644
> --- a/arch/arm/boot/dts/imx28-cfa10036.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10036.dts
> @@ -66,7 +66,7 @@
>  
>  			};
>  
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a
> diff --git a/arch/arm/boot/dts/imx28-duckbill-2-485.dts b/arch/arm/boot/dts/imx28-duckbill-2-485.dts
> index 97084e463d7c..f4f2b3d16c8e 100644
> --- a/arch/arm/boot/dts/imx28-duckbill-2-485.dts
> +++ b/arch/arm/boot/dts/imx28-duckbill-2-485.dts
> @@ -25,7 +25,7 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_8bit_pins_a
> @@ -36,7 +36,7 @@
>  				non-removable;
>  			};
>  
> -			ssp2: ssp at 80014000 {
> +			ssp2: spi at 80014000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc2_4bit_pins_b
> diff --git a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
> index 22215337f72a..71d0fcbc2d8c 100644
> --- a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
> +++ b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
> @@ -26,7 +26,7 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_8bit_pins_a
> @@ -37,7 +37,7 @@
>  				non-removable;
>  			};
>  
> -			ssp2: ssp at 80014000 {
> +			ssp2: spi at 80014000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc2_4bit_pins_b
> diff --git a/arch/arm/boot/dts/imx28-duckbill-2-spi.dts b/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
> index 13e7b134da9e..6580ec6e26ba 100644
> --- a/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
> +++ b/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
> @@ -29,7 +29,7 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_8bit_pins_a
> @@ -40,7 +40,7 @@
>  				non-removable;
>  			};
>  
> -			ssp2: ssp at 80014000 {
> +			ssp2: spi at 80014000 {
>  				compatible = "fsl,imx28-spi";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&spi2_pins_a>;
> diff --git a/arch/arm/boot/dts/imx28-duckbill-2.dts b/arch/arm/boot/dts/imx28-duckbill-2.dts
> index 88556c93b00f..693634edae99 100644
> --- a/arch/arm/boot/dts/imx28-duckbill-2.dts
> +++ b/arch/arm/boot/dts/imx28-duckbill-2.dts
> @@ -25,7 +25,7 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_8bit_pins_a
> @@ -36,7 +36,7 @@
>  				non-removable;
>  			};
>  
> -			ssp2: ssp at 80014000 {
> +			ssp2: spi at 80014000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc2_4bit_pins_b
> diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
> index f286bfe699be..16f524428ed7 100644
> --- a/arch/arm/boot/dts/imx28-duckbill.dts
> +++ b/arch/arm/boot/dts/imx28-duckbill.dts
> @@ -24,7 +24,7 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a
> @@ -34,7 +34,7 @@
>  				status = "okay";
>  			};
>  
> -			ssp2: ssp at 80014000 {
> +			ssp2: spi at 80014000 {
>  				compatible = "fsl,imx28-spi";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&spi2_pins_a>;
> diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
> index 93ab5bdfe068..5778300f44e8 100644
> --- a/arch/arm/boot/dts/imx28-evk.dts
> +++ b/arch/arm/boot/dts/imx28-evk.dts
> @@ -103,7 +103,7 @@
>  				status = "okay";
>  			};
>  
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_8bit_pins_a
> @@ -114,13 +114,13 @@
>  				status = "okay";
>  			};
>  
> -			ssp1: ssp at 80012000 {
> +			ssp1: spi at 80012000 {
>  				compatible = "fsl,imx28-mmc";
>  				bus-width = <8>;
>  				wp-gpios = <&gpio0 28 0>;
>  			};
>  
> -			ssp2: ssp at 80014000 {
> +			ssp2: spi at 80014000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx28-spi";
> diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
> index 3bb5ffc644d6..8883d36a51b5 100644
> --- a/arch/arm/boot/dts/imx28-m28cu3.dts
> +++ b/arch/arm/boot/dts/imx28-m28cu3.dts
> @@ -41,7 +41,7 @@
>  				};
>  			};
>  
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a
> @@ -52,7 +52,7 @@
>  				status = "okay";
>  			};
>  
> -			ssp2: ssp at 80014000 {
> +			ssp2: spi at 80014000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc2_4bit_pins_a
> diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
> index 7d97a0ce74a3..893886d17b2d 100644
> --- a/arch/arm/boot/dts/imx28-m28evk.dts
> +++ b/arch/arm/boot/dts/imx28-m28evk.dts
> @@ -18,7 +18,7 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_8bit_pins_a
> @@ -30,7 +30,7 @@
>  				status = "okay";
>  			};
>  
> -			ssp2: ssp at 80014000 {
> +			ssp2: spi at 80014000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx28-spi";
> diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
> index 2393e83979e0..ea9212f6ecda 100644
> --- a/arch/arm/boot/dts/imx28-sps1.dts
> +++ b/arch/arm/boot/dts/imx28-sps1.dts
> @@ -40,7 +40,7 @@
>  
>  			};
>  
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a>;
> @@ -48,7 +48,7 @@
>  				status = "okay";
>  			};
>  
> -			ssp2: ssp at 80014000 {
> +			ssp2: spi at 80014000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx28-spi";
> diff --git a/arch/arm/boot/dts/imx28-ts4600.dts b/arch/arm/boot/dts/imx28-ts4600.dts
> index f8a09a8c2c36..dccdd6bcd0b2 100644
> --- a/arch/arm/boot/dts/imx28-ts4600.dts
> +++ b/arch/arm/boot/dts/imx28-ts4600.dts
> @@ -25,7 +25,7 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&mmc0_4bit_pins_a
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 5107fdc482ea..2b7efb659fc0 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -117,7 +117,7 @@
>  				status = "disabled";
>  			};
>  
> -			ssp0: ssp at 80010000 {
> +			ssp0: spi at 80010000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				reg = <0x80010000 0x2000>;
> @@ -128,7 +128,7 @@
>  				status = "disabled";
>  			};
>  
> -			ssp1: ssp at 80012000 {
> +			ssp1: spi at 80012000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				reg = <0x80012000 0x2000>;
> @@ -139,7 +139,7 @@
>  				status = "disabled";
>  			};
>  
> -			ssp2: ssp at 80014000 {
> +			ssp2: spi at 80014000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				reg = <0x80014000 0x2000>;
> @@ -150,7 +150,7 @@
>  				status = "disabled";
>  			};
>  
> -			ssp3: ssp at 80016000 {
> +			ssp3: spi at 80016000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				reg = <0x80016000 0x2000>;
> diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
> index ca1419ca303c..af7afccf5f2f 100644
> --- a/arch/arm/boot/dts/imx31.dtsi
> +++ b/arch/arm/boot/dts/imx31.dtsi
> @@ -206,7 +206,7 @@
>  				status = "disabled";
>  			};
>  
> -			spi2: cspi at 50010000 {
> +			spi2: spi at 50010000 {
>  				compatible = "fsl,imx31-cspi";
>  				reg = <0x50010000 0x4000>;
>  				interrupts = <13>;
> @@ -241,7 +241,7 @@
>  				#clock-cells = <1>;
>  			};
>  
> -			spi3: cspi at 53f84000 {
> +			spi3: spi at 53f84000 {
>  				compatible = "fsl,imx31-cspi";
>  				reg = <0x53f84000 0x4000>;
>  				interrupts = <17>;
> diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
> index 1c50b785cad4..a1c3d28e8771 100644
> --- a/arch/arm/boot/dts/imx35.dtsi
> +++ b/arch/arm/boot/dts/imx35.dtsi
> @@ -133,7 +133,7 @@
>  				status = "disabled";
>  			};
>  
> -			spi1: cspi at 43fa4000 {
> +			spi1: spi at 43fa4000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx35-cspi";
> @@ -174,7 +174,7 @@
>  				status = "disabled";
>  			};
>  
> -			spi2: cspi at 50010000 {
> +			spi2: spi at 50010000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx35-cspi";
> diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
> index 7fae2ffb76fe..95b7fba58300 100644
> --- a/arch/arm/boot/dts/imx50.dtsi
> +++ b/arch/arm/boot/dts/imx50.dtsi
> @@ -140,7 +140,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi1: ecspi at 50010000 {
> +				ecspi1: spi at 50010000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx50-ecspi", "fsl,imx51-ecspi";
> @@ -403,7 +403,7 @@
>  				status = "disabled";
>  			};
>  
> -			ecspi2: ecspi at 63fac000 {
> +			ecspi2: spi at 63fac000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx50-ecspi", "fsl,imx51-ecspi";
> @@ -426,7 +426,7 @@
>  				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx50.bin";
>  			};
>  
> -			cspi: cspi at 63fc0000 {
> +			cspi: spi at 63fc0000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx50-cspi", "fsl,imx35-cspi";
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 5c4ba91e43ba..48f9c27c9ca2 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -197,7 +197,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi1: ecspi at 70010000 {
> +				ecspi1: spi at 70010000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx51-ecspi";
> @@ -464,7 +464,7 @@
>  				status = "disabled";
>  			};
>  
> -			ecspi2: ecspi at 83fac000 {
> +			ecspi2: spi at 83fac000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx51-ecspi";
> @@ -487,7 +487,7 @@
>  				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
>  			};
>  
> -			cspi: cspi at 83fc0000 {
> +			cspi: spi at 83fc0000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx51-cspi", "fsl,imx35-cspi";
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 6386185ae234..207eb557c90e 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -259,7 +259,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi1: ecspi at 50010000 {
> +				ecspi1: spi at 50010000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx53-ecspi", "fsl,imx51-ecspi";
> @@ -684,7 +684,7 @@
>  				status = "disabled";
>  			};
>  
> -			ecspi2: ecspi at 63fac000 {
> +			ecspi2: spi at 63fac000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx53-ecspi", "fsl,imx51-ecspi";
> @@ -707,7 +707,7 @@
>  				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
>  			};
>  
> -			cspi: cspi at 63fc0000 {
> +			cspi: spi at 63fc0000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx53-cspi", "fsl,imx35-cspi";
> diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> index 9de45a717356..d08e0402793b 100644
> --- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> @@ -146,7 +146,7 @@
>  &ecspi4 {
>  	status = "okay";
>  
> -	mcp251x0: mcp251x at 1 {
> +	mcp251x0: mcp251x at 0 {
>  		compatible = "microchip,mcp2515";
>  		reg = <0>;
>  		clocks = <&clk16m>;
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 0193ee6fe964..8381d24eff7d 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -163,7 +163,7 @@
>  
>  		aips-bus at 2000000 { /* AIPS1 */
>  			spba-bus at 2000000 {
> -				ecspi5: ecspi at 2018000 {
> +				ecspi5: spi at 2018000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 61d2d26afbf4..e4daf150881a 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -317,7 +317,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi1: ecspi at 2008000 {
> +				ecspi1: spi at 2008000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
> @@ -331,7 +331,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi2: ecspi at 200c000 {
> +				ecspi2: spi at 200c000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
> @@ -345,7 +345,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi3: ecspi at 2010000 {
> +				ecspi3: spi at 2010000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
> @@ -359,7 +359,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi4: ecspi at 2014000 {
> +				ecspi4: spi at 2014000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 7a4f5dace902..7a3ae7160c12 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -168,7 +168,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi1: ecspi at 2008000 {
> +				ecspi1: spi at 2008000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6sl-ecspi", "fsl,imx51-ecspi";
> @@ -180,7 +180,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi2: ecspi at 200c000 {
> +				ecspi2: spi at 200c000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6sl-ecspi", "fsl,imx51-ecspi";
> @@ -192,7 +192,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi3: ecspi at 2010000 {
> +				ecspi3: spi at 2010000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6sl-ecspi", "fsl,imx51-ecspi";
> @@ -204,7 +204,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi4: ecspi at 2014000 {
> +				ecspi4: spi at 2014000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6sl-ecspi", "fsl,imx51-ecspi";
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 844caa39364f..95a3c1cb877d 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -268,7 +268,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi1: ecspi at 2008000 {
> +				ecspi1: spi at 2008000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6sx-ecspi", "fsl,imx51-ecspi";
> @@ -280,7 +280,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi2: ecspi at 200c000 {
> +				ecspi2: spi at 200c000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6sx-ecspi", "fsl,imx51-ecspi";
> @@ -292,7 +292,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi3: ecspi at 2010000 {
> +				ecspi3: spi at 2010000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6sx-ecspi", "fsl,imx51-ecspi";
> @@ -304,7 +304,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi4: ecspi at 2014000 {
> +				ecspi4: spi at 2014000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6sx-ecspi", "fsl,imx51-ecspi";
> @@ -1079,7 +1079,7 @@
>  				status = "disabled";
>  			};
>  
> -			qspi1: qspi at 21e0000 {
> +			qspi1: spi at 21e0000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx6sx-qspi";
> @@ -1092,7 +1092,7 @@
>  				status = "disabled";
>  			};
>  
> -			qspi2: qspi at 21e4000 {
> +			qspi2: spi at 21e4000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx6sx-qspi";
> @@ -1273,7 +1273,7 @@
>  				status = "disabled";
>  			};
>  
> -			ecspi5: ecspi at 228c000 {
> +			ecspi5: spi at 228c000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx6sx-ecspi", "fsl,imx51-ecspi";
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index 6dc0b569acdf..ed8d917b4664 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -218,7 +218,7 @@
>  				reg = <0x02000000 0x40000>;
>  				ranges;
>  
> -				ecspi1: ecspi at 2008000 {
> +				ecspi1: spi at 2008000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
> @@ -230,7 +230,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi2: ecspi at 200c000 {
> +				ecspi2: spi at 200c000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
> @@ -242,7 +242,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi3: ecspi at 2010000 {
> +				ecspi3: spi at 2010000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
> @@ -254,7 +254,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi4: ecspi at 2014000 {
> +				ecspi4: spi at 2014000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
> @@ -945,7 +945,7 @@
>  				status = "disabled";
>  			};
>  
> -			qspi: qspi at 21e0000 {
> +			qspi: spi at 21e0000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx6ul-qspi", "fsl,imx6sx-qspi";
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index a052198f6e96..eee90b369c12 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -644,7 +644,7 @@
>  				status = "disabled";
>  			};
>  
> -			ecspi4: ecspi at 30630000 {
> +			ecspi4: spi at 30630000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
> @@ -725,7 +725,7 @@
>  				reg = <0x30800000 0x100000>;
>  				ranges;
>  
> -				ecspi1: ecspi at 30820000 {
> +				ecspi1: spi at 30820000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
> @@ -737,7 +737,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi2: ecspi at 30830000 {
> +				ecspi2: spi at 30830000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
> @@ -749,7 +749,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi3: ecspi at 30840000 {
> +				ecspi3: spi at 30840000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index f18490548c78..74ae649ffa59 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -163,7 +163,7 @@
>  			big-endian;
>  		};
>  
> -		qspi: quadspi at 1550000 {
> +		qspi: spi at 1550000 {
>  			compatible = "fsl,ls1021a-qspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -330,7 +330,7 @@
>  			};
>  		};
>  
> -		dspi0: dspi at 2100000 {
> +		dspi0: spi at 2100000 {
>  			compatible = "fsl,ls1021a-v1.0-dspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -343,7 +343,7 @@
>  			status = "disabled";
>  		};
>  
> -		dspi1: dspi at 2110000 {
> +		dspi1: spi at 2110000 {
>  			compatible = "fsl,ls1021a-v1.0-dspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index d392794d9c13..5e3399939006 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -190,7 +190,7 @@
>  				status = "disabled";
>  			};
>  
> -			dspi0: dspi0 at 4002c000 {
> +			dspi0: spi at 4002c000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,vf610-dspi";
> @@ -205,7 +205,7 @@
>  				status = "disabled";
>  			};
>  
> -			dspi1: dspi1 at 4002d000 {
> +			dspi1: spi at 4002d000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,vf610-dspi";
> @@ -339,7 +339,7 @@
>  				status = "disabled";
>  			};
>  
> -			qspi0: quadspi at 40044000 {
> +			qspi0: spi at 40044000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,vf610-qspi";
> @@ -569,7 +569,7 @@
>  				status = "disabled";
>  			};
>  
> -			dspi2: dspi2 at 400ac000 {
> +			dspi2: spi at 400ac000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,vf610-dspi";
> @@ -584,7 +584,7 @@
>  				status = "disabled";
>  			};
>  
> -			dspi3: dspi3 at 400ad000 {
> +			dspi3: spi at 400ad000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,vf610-dspi";
> @@ -665,7 +665,7 @@
>  				status = "disabled";
>  			};
>  
> -			qspi1: quadspi at 400c4000 {
> +			qspi1: spi at 400c4000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,vf610-qspi";
