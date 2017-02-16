From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 21:15:05 -0600
Subject: [PATCH v2 1/7] dt-bindings: display: add STM32 LTDC driver
In-Reply-To: <1486740274-25958-2-git-send-email-yannick.fertre@st.com>
References: <1486740274-25958-1-git-send-email-yannick.fertre@st.com>
 <1486740274-25958-2-git-send-email-yannick.fertre@st.com>
Message-ID: <20170216031505.x7gbqivnv7pvdzei@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 04:24:28PM +0100, Yannick Fertre wrote:
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---
>  .../devicetree/bindings/display/st,stm32-ltdc.txt  | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> new file mode 100644
> index 0000000..b93e1c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> @@ -0,0 +1,37 @@
> +* STMicroelectronics STM32 lcd-tft display controller
> +
> +- ltdc: lcd-tft display controller host
> +  must be a sub-node of st-display-subsystem
> +  Required properties:
> +  - compatible: "st,stm32-ltdc"

Kind of generic. There's only one version for all stm32 parts?

> +  - reg: Physical base address of the IP registers and length of memory mapped region.
> +  - clocks: A list of phandle + clock-specifier pairs, one for each
> +    entry in 'clock-names'.
> +  - clock-names: A list of clock names. For ltdc it should contain:
> +      - "clk-lcd" for the clock feeding the output pixel clock & IP clock.
> +  - resets: reset to be used by the device (defined by use of RCC macro).
> +  Required nodes:
> +    - Video port for RGB output.
> +
> +Example:
> +
> +/ {
> +	...
> +	soc {
> +	...
> +		ltdc: stm32-ltdc at 40016800 {

display-controller at ...

> +			compatible = "st,stm32-ltdc";
> +			reg = <0x40016800 0x200>;
> +			interrupts = <88>, <89>;
> +			resets = <&rcc STM32F4_APB2_RESET(LTDC)>;
> +			clocks = <&rcc 1 CLK_LCD>;
> +			clock-names = "lcd";
> +			status = "disabled";

Don't need to show status in examples.

> +
> +			port {
> +				ltdc_out_rgb: endpoint {
> +				};
> +			};
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
