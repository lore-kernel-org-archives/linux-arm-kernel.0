From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 04 Jun 2014 13:24:57 +0200
Subject: [PATCH v2 3/7] ARM: shmobile: r8a7791 dtsi: add SYS-DMAC clocks
In-Reply-To: <1401716531-29794-4-git-send-email-geert+renesas@glider.be>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
 <1401716531-29794-4-git-send-email-geert+renesas@glider.be>
Message-ID: <1507846.mqylbqQs2V@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Monday 02 June 2014 15:42:07 Geert Uytterhoeven wrote:
> Add clocks for the SYS-DMAC0 and SYS-DMAC1 hardware blocks.
> 
> Cfr. the r8a7790 version by Ben Dooks.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2:
>   - No changes
> 
>  arch/arm/boot/dts/r8a7791.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 8d7ffaeff6e0..e5c35d784ec8 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -743,16 +743,19 @@
>  			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-
clocks";
>  			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
>  			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
> -				 <&mp_clk>, <&mp_clk>, <&mp_clk>;
> +				 <&mp_clk>, <&mp_clk>, <&mp_clk>,
> +				 <&zs_clk>, <&zs_clk>;
>  			#clock-cells = <1>;
>  			renesas,clock-indices = <
>  				R8A7791_CLK_SCIFA2 R8A7791_CLK_SCIFA1 R8A7791_CLK_SCIFA0
>  				R8A7791_CLK_MSIOF2 R8A7791_CLK_SCIFB0 R8A7791_CLK_SCIFB1
>  				R8A7791_CLK_MSIOF1 R8A7791_CLK_SCIFB2
> +				R8A7791_CLK_SYS_DMAC1 R8A7791_CLK_SYS_DMAC0
> 
>  			>;
> 
>  			clock-output-names =
>  				"scifa2", "scifa1", "scifa0", "msiof2", "scifb0",
> -				"scifb1", "msiof1", "scifb2";
> +				"scifb1", "msiof1", "scifb2",
> +				"sys-dmac1", "sys-dmac0";
>  		};
>  		mstp3_clks: mstp3_clks at e615013c {
>  			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-
clocks";

-- 
Regards,

Laurent Pinchart
