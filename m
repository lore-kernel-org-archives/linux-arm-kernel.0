From: philippe.cornu@st.com (Philippe CORNU)
Date: Thu, 25 Jan 2018 16:08:35 +0000
Subject: [PATCH] dt-bindings: display: stm32: add pixel clock mandatory
 property
In-Reply-To: <20180122153805.23720-1-philippe.cornu@st.com>
References: <20180122153805.23720-1-philippe.cornu@st.com>
Message-ID: <881ad794-6c4a-b753-2325-ac8522f8a70c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

in short: this patch is "CANCELLED" : )

There is no need to add the pixel clock as a mandatory property because 
now the clock value is ajusted in adjusted_mode.

Please have a look to patches:
- drm/stm: ltdc: use crtc_mode_fixup to update adjusted_mode clock
- drm/bridge/synopsys: dsi: use adjusted_mode in mode_set

Hope it is better, comments are welcome

Many thanks,
Philippe :-)

On 01/22/2018 04:38 PM, Philippe Cornu wrote:
> Add the DPI/RGB input pixel clock in mandatory properties
> because it really offers a better preciseness for timing
> computations.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
> Please apply "dt-bindings: display: stm32: correct clock-names
> in dsi panel example" before this patch.
> 
> Changes in v3: remove the note regarding swapped clock names
>    (now in a separate patch).
> Changes in v2: put new clock in last position (Rob Herring)
> 
>   Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> index 3eb1b48b47dd..942b7237ae87 100644
> --- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> @@ -29,6 +29,7 @@ Mandatory properties specific to STM32 DSI:
>   - compatible: "st,stm32-dsi".
>   - clock-names:
>     - phy pll reference clock string name, must be "ref".
> +  - DPI/RGB input pixel clock string name, must be "px_clk".
>   - resets: see [5].
>   - reset-names: see [5].
>   
> @@ -97,8 +98,9 @@ Example 2: DSI panel
>   			#size-cells = <0>;
>   			compatible = "st,stm32-dsi";
>   			reg = <0x40016c00 0x800>;
> -			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>;
> -			clock-names = "pclk", "ref";
> +			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>,
> +				 <&rcc 1 CLK_LCD>;
> +			clock-names = "pclk", "ref", "px_clk";
>   			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
>   			reset-names = "apb";
>   
> 
