From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 Jan 2015 09:36:05 +0900
Subject: [PATCH] ARM: shmobile: r8a7791: fix MSTP8 input clocks
In-Reply-To: <4221957.7dd2kFrTHY@wasted.cogentembedded.com>
References: <4221957.7dd2kFrTHY@wasted.cogentembedded.com>
Message-ID: <20150113003604.GB27284@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 01:31:14AM +0300, Sergei Shtylyov wrote:
> I made  a mistake when rebasing Andrey Gusakov's patch adding MLB+ clock to the
> R8A7791 device  tree, inserting <&hp_clk> into the "clocks"  property of the
> MSTP8 node at a wrong position, so that the input clocks for MLB+ and IPMMU-SGX
> got swapped...
> 
> Fixes: 7408d3061d2f ("ARM: shmobile: r8a7791: add MLB+ clock")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against 'renesas-devel-20150108v2-v3.19-rc3' tag of Simon Horman's
> 'renesas.git' repo.

Thanks, I have queued this up.

> 
>  arch/arm/boot/dts/r8a7791.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7791.dtsi
> @@ -1196,7 +1196,7 @@
>  		mstp8_clks: mstp8_clks at e6150990 {
>  			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
>  			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> -			clocks = <&hp_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
> +			clocks = <&zg_clk>, <&hp_clk>, <&zg_clk>, <&zg_clk>,
>  			         <&zg_clk>, <&p_clk>, <&zs_clk>, <&zs_clk>;
>  			#clock-cells = <1>;
>  			clock-indices = <
> 
