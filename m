From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 23 May 2014 11:36:16 +0200
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7779 dtsi: Correct
 #address-cells/#size-cells for clocks
In-Reply-To: <1400831180-20409-2-git-send-email-geert+renesas@glider.be>
References: <1400831180-20409-1-git-send-email-geert+renesas@glider.be>
 <1400831180-20409-2-git-send-email-geert+renesas@glider.be>
Message-ID: <1821194.NVbl22FVTm@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Friday 23 May 2014 09:46:19 Geert Uytterhoeven wrote:
> Warning (ranges_format): /clocks has empty "ranges" property but its
> #address-cells (2) differs from / (1) Warning (ranges_format): /clocks has
> empty "ranges" property but its #size-cells (2) differs from / (1)
> 
> As r8a7779 doesn't support LPAE, change #address-cells and #size-cells from
> "<2>" to "<1>", and update the affected "reg" properties to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Is it correct that r8a7779 doesn't support LPAE? I don't have the datasheet,
> but the similar r8a7778 doesn't.
> 
> v2:
>   - Spin off unit-addresses updates into a separate patch.
> 
>  arch/arm/boot/dts/r8a7779.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> index 038c16a18373..395a611e2b5a 100644
> --- a/arch/arm/boot/dts/r8a7779.dtsi
> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> @@ -284,8 +284,8 @@
>  	};
> 
>  	clocks {
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
>  		ranges;
> 
>  		/* External root clock */
> @@ -300,7 +300,7 @@
>  		/* Special CPG clocks */
>  		cpg_clocks: cpg_clocks at 0xe6150000 {
>  			compatible = "renesas,r8a7779-cpg-clocks";
> -			reg = <0 0xffc80000 0 0x30>;
> +			reg = <0xffc80000 0x30>;
>  			clocks = <&extal_clk>;
>  			#clock-cells = <1>;
>  			clock-output-names = "plla", "z", "zs", "s",
> @@ -345,7 +345,7 @@
>  		mstp0_clks: mstp0_clks {
>  			compatible = "renesas,r8a7779-mstp-clocks",
>  			             "renesas,cpg-mstp-clocks";
> -			reg = <0 0xffc80030 0 4>;
> +			reg = <0xffc80030 4>;
>  			clocks = <&cpg_clocks R8A7779_CLK_S>,
>  			         <&cpg_clocks R8A7779_CLK_P>,
>  				 <&cpg_clocks R8A7779_CLK_P>,
> @@ -382,7 +382,7 @@
>  		mstp1_clks: mstp1_clks {
>  			compatible = "renesas,r8a7779-mstp-clocks",
>  			             "renesas,cpg-mstp-clocks";
> -			reg = <0 0xffc80034 0 4>, <0 0xffc80044 0 4>;
> +			reg = <0xffc80034 4>, <0xffc80044 4>;
>  			clocks = <&cpg_clocks R8A7779_CLK_P>,
>  				 <&cpg_clocks R8A7779_CLK_P>,
>  				 <&cpg_clocks R8A7779_CLK_S>,
> @@ -411,7 +411,7 @@
>  		mstp3_clks: mstp3_clks {
>  			compatible = "renesas,r8a7779-mstp-clocks",
>  			             "renesas,cpg-mstp-clocks";
> -			reg = <0 0xffc8003c 0 4>;
> +			reg = <0xffc8003c 4>;
>  			clocks = <&s4_clk>, <&s4_clk>, <&s4_clk>, <&s4_clk>,
>  				 <&s4_clk>, <&s4_clk>;
>  			#clock-cells = <1>;

-- 
Regards,

Laurent Pinchart
