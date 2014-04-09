From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 9 Apr 2014 11:21:19 +0800
Subject: [PATCH] ARM: dts: i.MX: Use single naming style for i.MX WEIM
 devices
In-Reply-To: <1396972483-2342-1-git-send-email-shc_work@mail.ru>
References: <1396972483-2342-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140409032117.GA2611@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 07:54:43PM +0400, Alexander Shiyan wrote:
> This patch converts all i.MX WEIM users to use single naming style
> for devices.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  Documentation/devicetree/bindings/bus/imx-weim.txt | 4 ++--
>  arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     | 2 +-
>  arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    | 4 ++--
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
> index 6630d84..73aa2f3 100644
> --- a/Documentation/devicetree/bindings/bus/imx-weim.txt
> +++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
> @@ -70,9 +70,9 @@ Example for an imx6q-sabreauto board, the NOR flash connected to the WEIM:
>  		ranges = <0 0 0x08000000 0x08000000>;
>  		fsl,weim-cs-gpr = <&gpr>;
>  
> -		nor at 0,0 {
> +		nor at 0,00000000 {

Hmm, I think the idiom for unit-address is that the number has neither
'0x' nor leading zeros.  That said, the existing form is just good.

Shawn

>  			compatible = "cfi-flash";
> -			reg = <0 0 0x02000000>;
> +			reg = <0 0x00000000 0x02000000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			bank-width = <2>;
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> index 9117a3c..e501aa9 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> @@ -280,7 +280,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_weim>;
>  
> -	can at d4000000 {
> +	can at 4,00000000 {
>  		compatible = "nxp,sja1000";
>  		reg = <4 0x00000000 0x00000100>;
>  		interrupt-parent = <&gpio5>;
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> index 8e10aef..758612a 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> @@ -311,7 +311,7 @@
>  &weim {
>  	status = "okay";
>  
> -	nor: nor at c0000000 {
> +	nor: nor at 0,00000000 {
>  		compatible = "cfi-flash";
>  		reg = <0 0x00000000 0x02000000>;
>  		bank-width = <2>;
> @@ -321,7 +321,7 @@
>  		#size-cells = <1>;
>  	};
>  
> -	sram: sram at c8000000 {
> +	sram: sram at 1,00000000 {
>  		compatible = "mtd-ram";
>  		reg = <1 0x00000000 0x00800000>;
>  		bank-width = <2>;
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 009abd6..fde8b31 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -446,9 +446,9 @@
>  	ranges = <0 0 0x08000000 0x08000000>;
>  	status = "disabled"; /* pin conflict with SPI NOR */
>  
> -	nor at 0,0 {
> +	nor at 0,00000000 {
>  		compatible = "cfi-flash";
> -		reg = <0 0 0x02000000>;
> +		reg = <0 0x00000000 0x02000000>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		bank-width = <2>;
> -- 
> 1.8.3.2
> 
> 
> 
