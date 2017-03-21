From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Mar 2017 13:54:18 -0700
Subject: [PATCH v4 1/8] dt-bindings: display: add STM32 LTDC driver
In-Reply-To: <1489597334-16896-2-git-send-email-yannick.fertre@st.com>
References: <1489597334-16896-1-git-send-email-yannick.fertre@st.com>
 <1489597334-16896-2-git-send-email-yannick.fertre@st.com>
Message-ID: <87k27inyf9.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yannick Fertre <yannick.fertre@st.com> writes:

> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---
>  .../devicetree/bindings/display/st,stm32-ltdc.txt  | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> new file mode 100644
> index 0000000..e8d39c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> @@ -0,0 +1,36 @@
> +* STMicroelectronics STM32 lcd-tft display controller
> +
> +- ltdc: lcd-tft display controller host
> +  must be a sub-node of st-display-subsystem
> +  Required properties:
> +  - compatible: "st,stm32-ltdc"
> +  - reg: Physical base address of the IP registers and length of memory mapped region.
> +  - clocks: A list of phandle + clock-specifier pairs, one for each
> +    entry in 'clock-names'.
> +  - clock-names: A list of clock names. For ltdc it should contain:
> +      - "clk-lcd" for the clock feeding the output pixel clock & IP clock.

I think you meant "lcd" here.

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
> +		ltdc: display-controller at 40016800 {
> +			compatible = "st,stm32-ltdc";
> +			reg = <0x40016800 0x200>;
> +			interrupts = <88>, <89>;
> +			resets = <&rcc STM32F4_APB2_RESET(LTDC)>;
> +			clocks = <&rcc 1 CLK_LCD>;
> +			clock-names = "lcd";
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
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170321/eec68f6b/attachment-0001.sig>
