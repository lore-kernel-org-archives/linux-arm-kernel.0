From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Jan 2018 16:43:35 -0600
Subject: [PATCH v2] dt-bindings: display: stm32: add pixel clock
 mandatory property
In-Reply-To: <20180112153034.20353-1-philippe.cornu@st.com>
References: <20180112153034.20353-1-philippe.cornu@st.com>
Message-ID: <20180119224335.exrxcfq3xc6op6iy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 04:30:34PM +0100, Philippe Cornu wrote:
> Add the DPI/RGB input pixel clock in mandatory properties
> because it really offers a better preciseness for timing
> computations.
> Note: Fix also the DSI panel example where "ref" & "pclk"
> clocks were swapped.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
> Changes in v2: put new clock in last position (Rob Herring)
> 
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> index 029252253ad4..942b7237ae87 100644
> --- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> @@ -29,6 +29,7 @@ Mandatory properties specific to STM32 DSI:
>  - compatible: "st,stm32-dsi".
>  - clock-names:
>    - phy pll reference clock string name, must be "ref".
> +  - DPI/RGB input pixel clock string name, must be "px_clk".
>  - resets: see [5].
>  - reset-names: see [5].
>  
> @@ -97,8 +98,9 @@ Example 2: DSI panel
>  			#size-cells = <0>;
>  			compatible = "st,stm32-dsi";
>  			reg = <0x40016c00 0x800>;
> -			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>;
> -			clock-names = "ref", "pclk";
> +			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>,
> +				 <&rcc 1 CLK_LCD>;
> +			clock-names = "pclk", "ref", "px_clk";

You have the existing names reversed here.

>  			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
>  			reset-names = "apb";
>  
> -- 
> 2.15.1
> 
