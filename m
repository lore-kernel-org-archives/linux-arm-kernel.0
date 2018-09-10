From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Sep 2018 08:39:47 +0800
Subject: [PATCH v2 1/5] arm64: dts: fsl: use a generic node name for
 m25p80 flashes
In-Reply-To: <20180903140840.23648-1-alexandre.belloni@bootlin.com>
References: <20180903140840.23648-1-alexandre.belloni@bootlin.com>
Message-ID: <20180910003946.GE21218@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series looks good to me.  @Leo, what about you?

Shawn

On Mon, Sep 03, 2018 at 04:08:36PM +0200, Alexandre Belloni wrote:
> Use a generic node name for the m25p80 flashes on ls1043 and ls1046 boards.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> index c7b8d2c009cd..af972e91d6bc 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> @@ -136,7 +136,7 @@
>  	bus-num = <0>;
>  	status = "okay";
>  
> -	qflash0: s25fl128s at 0 {
> +	qflash0: flash at 0 {
>  		compatible = "spansion,m25p80";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> index e69306e6b0b1..219068220b84 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> @@ -165,7 +165,7 @@
>  	bus-num = <0>;
>  	status = "okay";
>  
> -	qflash0: s25fl128s at 0 {
> +	qflash0: flash at 0 {
>  		compatible = "spansion,m25p80";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> index 440e111651d5..df676b30357b 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> @@ -103,7 +103,7 @@
>  	bus-num = <0>;
>  	status = "okay";
>  
> -	qflash0: s25fs512s at 0 {
> +	qflash0: flash at 0 {
>  		compatible = "spansion,m25p80";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -111,7 +111,7 @@
>  		reg = <0>;
>  	};
>  
> -	qflash1: s25fs512s at 1 {
> +	qflash1: flash at 1 {
>  		compatible = "spansion,m25p80";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -- 
> 2.19.0.rc1
> 
