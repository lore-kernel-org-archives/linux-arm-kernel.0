From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Nov 2013 09:31:40 +0000
Subject: [PATCH] irqchip: renesas-intc: Document DT bindings
In-Reply-To: <1385620847-18919-1-git-send-email-horms+renesas@verge.net.au>
References: <1385620847-18919-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20131128093140.GA5929@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 06:40:47AM +0000, Simon Horman wrote:
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  .../interrupt-controller/renesas,intc-irqc.txt     | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqc.txt
> new file mode 100644
> index 0000000..305d4e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqc.txt
> @@ -0,0 +1,30 @@
> +DT bindings for the R-/SH-Mobile INTC controller
> +
> +Required properties:
> +
> +- compatible: Must be one of the following:

s/be/contain/

> +    "renesas,intc"
> +    "renesas,intc-r8a73a4"
> +    "renesas,intc-r8a7790"
> +    "renesas,intc-r8a7791"
> +- #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
> +  interrupts.txt in this directory

I assume you also require a reg to be able to poke the MMIO registers.

And an interrupt-controller annotation.

The example has a series of interrupts. How many do you expect, and what
do they logically correspond to (are they all equivalent, does one
signal errrors, etc)? Are they required or optional?

> +
> +Optional properties:
> +
> +- any properties, listed in interrupts.txt, and any standard resource allocation
> +  properties

This is a useless description.

What are "resource allocation properties"?

> +
> +Example:
> +
> +        irqc0: interrupt-controller at e61c0000 {
> +                compatible = "renesas,irqc-r8a7790", "renesas,irqc";

Do you always expect "renesas,irqc" to be in the list?

> +                #interrupt-cells = <2>;
> +                interrupt-controller;
> +                reg = <0 0xe61c0000 0 0x200>;
> +                interrupt-parent = <&gic>;
> +                interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
> +                             <0 1 IRQ_TYPE_LEVEL_HIGH>,
> +                             <0 2 IRQ_TYPE_LEVEL_HIGH>,
> +                             <0 3 IRQ_TYPE_LEVEL_HIGH>;

As mentioned above, these were not described at all.

Thanks,
Mark.
