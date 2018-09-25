From: leoyang.li@nxp.com (Leo Li)
Date: Tue, 25 Sep 2018 13:26:44 +0000
Subject: [PATCH 1/2] arm64: freescale: Use "spi" as name for SPI
 controllers
In-Reply-To: <20180924094009.19344-1-thierry.reding@gmail.com>
References: <20180924094009.19344-1-thierry.reding@gmail.com>
Message-ID: <DBXPR04MB51124E9A4C4F2E9D8C79B978F160@DBXPR04MB511.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Monday, September 24, 2018 4:40 AM
> To: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: [PATCH 1/2] arm64: freescale: Use "spi" as name for SPI controllers
> 
> From: Thierry Reding <treding@nvidia.com>
> 
> Recent versions of DTC contain additional checks for SPI busses and warn
> about certain common mistakes, such as when an SPI controller has a name
> other than "spi".

Thanks.  There is another patch pending for this.  
https://patchwork.kernel.org/patch/10599953/

> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 2 +-
> arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 6 +++---
> arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 4 ++--
> arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> index 68ac78c4564d..5da732f82fa0 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -337,7 +337,7 @@
>  			status = "disabled";
>  		};
> 
> -		dspi: dspi at 2100000 {
> +		dspi: spi at 2100000 {
>  			compatible = "fsl,ls1012a-dspi", "fsl,ls1021a-v1.0-dspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 6cc4c87614b6..3fed504b5381 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -284,7 +284,7 @@
>  			interrupts = <0 43 0x4>;
>  		};
> 
> -		qspi: quadspi at 1550000 {
> +		qspi: spi at 1550000 {
>  			compatible = "fsl,ls1043a-qspi", "fsl,ls1021a-qspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -382,7 +382,7 @@
>  			ranges = <0x0 0x5 0x00000000 0x8000000>;
>  		};
> 
> -		dspi0: dspi at 2100000 {
> +		dspi0: spi at 2100000 {
>  			compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-dspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -395,7 +395,7 @@
>  			status = "disabled";
>  		};
> 
> -		dspi1: dspi at 2110000 {
> +		dspi1: spi at 2110000 {
>  			compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-dspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 3a2a14a8e187..51cbd50012d6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -202,7 +202,7 @@
>  			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> 
> -		qspi: quadspi at 1550000 {
> +		qspi: spi at 1550000 {
>  			compatible = "fsl,ls1021a-qspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -361,7 +361,7 @@
>  			#thermal-sensor-cells = <1>;
>  		};
> 
> -		dspi: dspi at 2100000 {
> +		dspi: spi at 2100000 {
>  			compatible = "fsl,ls1021a-v1.0-dspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 547a86ec7cd2..e45607419692 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -485,7 +485,7 @@
>  			mmu-masters = <&fsl_mc 0x300 0>;
>  		};
> 
> -		dspi: dspi at 2100000 {
> +		dspi: spi at 2100000 {
>  			status = "disabled";
>  			compatible = "fsl,ls2080a-dspi", "fsl,ls2085a-dspi";
>  			#address-cells = <1>;
> @@ -611,7 +611,7 @@
>  				  3 0 0x5 0x20000000 0x00010000>;
>  		};
> 
> -		qspi: quadspi at 20c0000 {
> +		qspi: spi at 20c0000 {
>  			status = "disabled";
>  			compatible = "fsl,ls2080a-qspi", "fsl,ls1021a-qspi";
>  			#address-cells = <1>;
> --
> 2.19.0
