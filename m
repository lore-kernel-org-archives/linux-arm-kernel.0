From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 12 Jan 2015 23:40:21 +0300
Subject: [PATCH] ARM: shmobile: r8a7791: add MLB+ clock
In-Reply-To: <7846462.yepFC759KH@wasted.cogentembedded.com>
References: <7846462.yepFC759KH@wasted.cogentembedded.com>
Message-ID: <54B43135.6000002@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/18/2014 11:43 PM, Sergei Shtylyov wrote:

> From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>

> Add MLB+ clock to R8A7791 device tree.

> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> [Sergei: rebased, renamed, added changelog]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> This patch is against 'renesas-devel-20141218-v3.18' tag of Simon Horman's
> 'renesas.git' repo.

>   arch/arm/boot/dts/r8a7791.dtsi            |   10 +++++-----
>   include/dt-bindings/clock/r8a7791-clock.h |    1 +
>   2 files changed, 6 insertions(+), 5 deletions(-)

> Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7791.dtsi
> @@ -1154,17 +1154,17 @@
>   		mstp8_clks: mstp8_clks at e6150990 {
>   			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
>   			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> -			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>,
> -				 <&zs_clk>, <&zs_clk>;
> +			clocks = <&hp_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,

    Oops, the first two clocks need to be swapped. I'll send a fix (since this 
patch has been merged already).

> +			         <&zg_clk>, <&p_clk>, <&zs_clk>, <&zs_clk>;
>   			#clock-cells = <1>;
>   			clock-indices = <
> -				R8A7791_CLK_IPMMU_SGX
> +				R8A7791_CLK_IPMMU_SGX R8A7791_CLK_MLB
>   				R8A7791_CLK_VIN2 R8A7791_CLK_VIN1 R8A7791_CLK_VIN0
>   				R8A7791_CLK_ETHER R8A7791_CLK_SATA1 R8A7791_CLK_SATA0
>   			>;
[...]

WBR, Sergei
