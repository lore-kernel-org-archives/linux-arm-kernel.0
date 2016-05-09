From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 9 May 2016 15:50:00 +0300
Subject: [PATCH 1/2] doc/devicetree: Add Aspeed VIC bindings
In-Reply-To: <1462797239-14765-2-git-send-email-joel@jms.id.au>
References: <1462797239-14765-1-git-send-email-joel@jms.id.au>
 <1462797239-14765-2-git-send-email-joel@jms.id.au>
Message-ID: <20160509124959.GM4414@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joel,

On Mon, May 09, 2016 at 10:03:58PM +0930, Joel Stanley wrote:
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
> +
> +Example:
> +
> + vic: interrupt-controller {
> +      compatible = "aspeed,ast2400-new-vic";

That doesn't match the compatible string documented above.

> +      interrupt-controller;
> +      #interrupt-cells = <1>;
> +      valid-sources = < 0xffffffff 0x0007ffff>;
> +      reg = <0x1e6c0080 0x80>;
> + };

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
