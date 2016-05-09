From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 9 May 2016 16:20:04 +0100
Subject: [PATCH 1/2] doc/devicetree: Add Aspeed VIC bindings
In-Reply-To: <1462797239-14765-2-git-send-email-joel@jms.id.au>
References: <1462797239-14765-1-git-send-email-joel@jms.id.au>
 <1462797239-14765-2-git-send-email-joel@jms.id.au>
Message-ID: <20160509152003.GA13842@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 10:03:58PM +0930, Joel Stanley wrote:
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../interrupt-controller/aspeed,ast2400-vic.txt    | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
> new file mode 100644
> index 000000000000..10ed0c20ee6f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
> @@ -0,0 +1,24 @@
> +Aspeed Vectored Interrupt Controller
> +
> +These bindings are for the Aspeed AST2400 interrupt controller register layout.
> +The SoC has an legacy register layout, but this driver does not support that
> +mode of operation.
> +
> +Required properties:
> +
> +- compatible : should be "aspeed,ast2400-vic".
> +
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.
> +- valid-sources : bitmask of valid irq sources

Generally we steer clear of this kind of bitmap encoding in DT.

Is this actually necessary? What does htis gain us?

Why can we not just register with the full set of possible interrupts?

Thanks,
Mark.

> +
> +Example:
> +
> + vic: interrupt-controller {
> +      compatible = "aspeed,ast2400-new-vic";
> +      interrupt-controller;
> +      #interrupt-cells = <1>;
> +      valid-sources = < 0xffffffff 0x0007ffff>;
> +      reg = <0x1e6c0080 0x80>;
> + };
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
