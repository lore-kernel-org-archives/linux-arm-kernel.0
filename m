From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 15:46:39 -0500
Subject: [PATCH 1/4] drm/tve200: Add DT bindings
In-Reply-To: <20170813151132.24736-2-linus.walleij@linaro.org>
References: <20170813151132.24736-1-linus.walleij@linaro.org>
 <20170813151132.24736-2-linus.walleij@linaro.org>
Message-ID: <20170817204639.euyygue22s33atak@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 13, 2017 at 05:11:29PM +0200, Linus Walleij wrote:
> This adds device tree bindings for the Faraday TVE200 IP block.
> This IP block is present in the Gemini ARM SoC and also in some
> Grain Media GMxxxx SoCs.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/display/faraday,tve200.txt | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/faraday,tve200.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/faraday,tve200.txt b/Documentation/devicetree/bindings/display/faraday,tve200.txt
> new file mode 100644
> index 000000000000..95d588fbb2f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/faraday,tve200.txt
> @@ -0,0 +1,41 @@
> +* Faraday TV Encoder TVE200
> +
> +Required properties:
> +
> +- compatible: must be one of:
> +	"faraday,tve200"
> +	"cortina,gemini-tvc", "faraday,tve200"
> +
> +- reg: base address and size of the control registers block
> +
> +- interrupts: contains an interrupt specifier for the interrupt
> +	line from the TVE200
> +
> +- clock-names: should contain "PCLK" for the clock line clocking the
> +	silicon and "TVE" for the 27MHz clock to the video driver
> +
> +- clocks: contains phandle and clock specifier pairs for the entries
> +	in the clock-names property. See
> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Optional properties:
> +
> +- resets: contains the reset line phandle for the block
> +
> +Required sub-nodes:
> +
> +- port: describes LCD panel signals, following the common binding
> +	for video transmitter interfaces; see
> +	Documentation/devicetree/bindings/media/video-interfaces.txt

Need to explicitly list ports and endpoints.

Also, needs to be in the example as it is required.

> +
> +Example:
> +
> +tvc at 6a000000 {

display-controller at ...

> +	compatible = "faraday,tve200";
> +	reg = <0x6a000000 0x1000>;
> +	interrupts = <13 IRQ_TYPE_EDGE_RISING>;
> +	resets = <&syscon GEMINI_RESET_TVC>;
> +	clocks = <&syscon GEMINI_CLK_GATE_TVC>,
> +		 <&syscon GEMINI_CLK_TVC>;
> +	clock-names = "PCLK", "TVE";
> +};
> -- 
> 2.13.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
