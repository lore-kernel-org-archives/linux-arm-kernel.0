From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Jul 2013 15:19:32 +0200
Subject: How to create IRQ mappings in a GPIO driver that doesn't control
 its IRQ domain ?
In-Reply-To: <1408178.cxAUTUGJc5@avalon>
References: <1624911.6TtmtVmU1T@avalon>
 <CACRpkdazPX3EbVbLvXQZh0oRBpHoWPK+EkFO75v9zfAXSPCkHA@mail.gmail.com>
 <1408178.cxAUTUGJc5@avalon>
Message-ID: <CACRpkdaNfFqzN0nYPrXd8ZVOFur6W2iEUSM_KErH6eKoiJ7vDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 11:45 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> The two devices are independent, so there's no real parent/child relationship.
> However, as Grant proposed, I could list all the interrupts associated with
> GPIOs in the GPIO controller DT node. I would then just call
> irq_of_parse_and_map() in the .to_irq() handler to magically translate the
> GPIO number to a mapped IRQ number.

That works even if the device tree will need a comment or two
to explain what is going on.

I suggested a similar solution for the OMAP crossbar mux
that is discussed in another thread, so I'm happy with this
approach.

Yours,
Linus Walleij
