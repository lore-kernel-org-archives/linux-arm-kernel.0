From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 4 May 2018 10:18:10 +0200
Subject: [PATCH 4/4] ARM: dts: imx: drop 'clocks' container for board
 level clocks
In-Reply-To: <1525395446-1953-5-git-send-email-shawnguo@kernel.org>
References: <1525395446-1953-1-git-send-email-shawnguo@kernel.org>
 <1525395446-1953-5-git-send-email-shawnguo@kernel.org>
Message-ID: <20180504101810.065b01f6@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri,  4 May 2018 08:57:26 +0800 Shawn Guo wrote:
> For soc level of clocks which are input to Clock Control Module, clock
> driver expects them to be under 'clocks' container node.  But for board
> level clocks, this container is not really necessary.  Let's drop it and
> use an unique name for fixed rate clock, so that 'reg' property can be
> saved as well.
> 
For imx28-tx28.dts and imx53-tx53.dtsi:
Acked-By: Lothar Wa?mann <LW@KARO-electronics.de>

> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
>  arch/arm/boot/dts/imx28-tx28.dts             | 13 ++++---------
>  arch/arm/boot/dts/imx53-tx53.dtsi            | 11 +++++------
>  arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 15 ++++++---------
>  arch/arm/boot/dts/imx6q-bx50v3.dtsi          | 11 ++++-------
>  4 files changed, 19 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
> index 687186358c18..e4f19f9be6d0 100644
> --- a/arch/arm/boot/dts/imx28-tx28.dts
> +++ b/arch/arm/boot/dts/imx28-tx28.dts
> @@ -140,15 +140,10 @@
>  		regulator-boot-on;
>  	};
>  
> -	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		mclk: clock at 0 {
> -			compatible = "fixed-clock";
> -			reg = <0>;
> -			#clock-cells = <0>;
> -			clock-frequency = <26000000>;
> -		};
> +	mclk: clock-mclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
>  	};
>  
>  	sound {
> diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
> index 77f2ce9f1e41..5dd3dd3a2fd0 100644
> --- a/arch/arm/boot/dts/imx53-tx53.dtsi
> +++ b/arch/arm/boot/dts/imx53-tx53.dtsi
> @@ -67,13 +67,12 @@
>  		ckih1 {
>  			clock-frequency = <0>;
>  		};
> +	};
>  
> -		mclk: clock at 0 {
> -			compatible = "fixed-clock";
> -			reg = <0>;
> -			#clock-cells = <0>;
> -			clock-frequency = <26000000>;
> -		};
> +	mclk: clock-mclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
>  	};
>  
>  	gpio-keys {
> diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> index ea184d108491..3dee3af1a4c1 100644
> --- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> @@ -72,15 +72,12 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	clocks {
> -		/* Fixed crystal dedicated to mcp251x */
> -		clk16m: clk at 1 {
> -			compatible = "fixed-clock";
> -			reg = <1>;
> -			#clock-cells = <0>;
> -			clock-frequency = <16000000>;
> -			clock-output-names = "clk16m";
> -		};
> +	/* Fixed crystal dedicated to mcp251x */
> +	clk16m: clock-16m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <16000000>;
> +		clock-output-names = "clk16m";
>  	};
>  
>  	gpio-keys {
> diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> index d0e7dab4d72b..d3cba09be0cb 100644
> --- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> +++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> @@ -43,13 +43,10 @@
>  #include "imx6q-ba16.dtsi"
>  
>  / {
> -	clocks {
> -		mclk: clock at 0 {
> -			compatible = "fixed-clock";
> -			reg = <0>;
> -			#clock-cells = <0>;
> -			clock-frequency = <22000000>;
> -		};
> +	mclk: clock-mclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <22000000>;
>  	};
>  
>  	gpio-poweroff {


Lothar Wa?mann
