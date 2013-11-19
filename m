From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Nov 2013 13:43:31 -0500
Subject: [PATCH 2/4] keystone: dts: add/modify clock nodes
In-Reply-To: <1384884788-29137-2-git-send-email-m-karicheri2@ti.com>
References: <1384884788-29137-1-git-send-email-m-karicheri2@ti.com>
 <1384884788-29137-2-git-send-email-m-karicheri2@ti.com>
Message-ID: <528BB153.60402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 November 2013 01:13 PM, Murali Karicheri wrote:
> K2 SoC has separate ref clock inputs for various clocks. This patch
> adds following changes:-
>  - Add separate ref clock nodes for ARM, DDR3A, DDR3B and PA PLL input
>    clocks
>  - While at it, rename  refclkmain to refclksys based on device User
>    Guide naming convention
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  arch/arm/boot/dts/keystone-clocks.dtsi |   48 ++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
> index d6713b1..3f1cf28 100644
> --- a/arch/arm/boot/dts/keystone-clocks.dtsi
> +++ b/arch/arm/boot/dts/keystone-clocks.dtsi
> @@ -13,17 +13,45 @@ clocks {
>  	#size-cells = <1>;
>  	ranges;
>  
> -	refclkmain: refclkmain {
> +	refclksys: refclksys {
>  		#clock-cells = <0>;
>  		compatible = "fixed-clock";
>  		clock-frequency = <122880000>;
> -		clock-output-names = "refclk-main";
> +		clock-output-names = "refclk-sys";
> +	};
> +
> +	refclkpass: refclkpass {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <122880000>;
> +		clock-output-names = "refclk-pass";
> +	};
> +

lets move these nodes which are board dependent to board file.
This came in for NAND patches as well. I suggested to create a
k2hk-evm.dts file.

Regards,
Santosh
