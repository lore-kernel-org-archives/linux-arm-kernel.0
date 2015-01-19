From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 19 Jan 2015 08:35:33 +0000
Subject: [PATCH v3 1/3] dt-bindings: mfd: add lubbock-io binding
In-Reply-To: <1421406010-14851-1-git-send-email-robert.jarzmik@free.fr>
References: <1421406010-14851-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150119083533.GF21886@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Jan 2015, Robert Jarzmik wrote:

> Add a binding for lubbock motherboard IO board.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  .../devicetree/bindings/mfd/lubbock-io.txt         | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/lubbock-io.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/lubbock-io.txt b/Documentation/devicetree/bindings/mfd/lubbock-io.txt
> new file mode 100644
> index 0000000..33c9e21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/lubbock-io.txt
> @@ -0,0 +1,26 @@
> +Intel's pxa255 system development platform motherboard.

s/pxa25/PXA25/

"system development platform motherboard" doesn't quite sit right with me.

How about "Intel Xscale PXA255 development platform (Lubbock)"?

> +This is the motherboard, or IO board, of the pxa25x development system,
> +supporting a lubbock pxa25x SoC board.

Again, this sounds weird.

> +Required properties:
> +  - compatible : One of the following chip-specific strings:
> +        "intel,lubbock-io"

An odd thing to say with only one entry.

Also, please line it up to the right of the ':' above.

> +  - interrupts : The first interrupt is the line the /IRQ signal the IO board
> +                 multiplex is connected to. The only known case is GPIO0 on the
> +                 pxa25x SoC.

Can you get someone to help you re-word this into a more fluid
sentence?

> +Optional properties:
> +  - interrupts : The second optional interrupt is the base of the interrupts
> +                 multiplexed by the lubbock motherboard. If unspecified, the
> +                 range is fully dynamic, and the irqdomain will generate its
> +                 interrupt base on the fly.
> +
> +Example:
> +
> +mb: lubbock-mb at 0 {
> +	compatible = "intel,lubbock-io";
> +	interrupts = <0 IRQ_TYPE_EDGE_FALLING 400 IRQ_TYPE_NONE>;
> +	#interrupt-cells = <2>;
> +        interrupt-parent = <&pxairq>;

Whitespace error.

> +};

I'm guessing mb means motherboard?  I think it's unusual for a
motherboard to have it's own driver.  Usually we provide drivers for
the individual components/peripherals situated on the board.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
