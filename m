From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Jun 2015 20:26:57 -0600
Subject: [PATCH] irqchip: bcm2835: Add FIQ support
In-Reply-To: <1434130016-26574-1-git-send-email-noralf@tronnes.org>
References: <1434130016-26574-1-git-send-email-noralf@tronnes.org>
Message-ID: <55822C71.2040409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2015 11:26 AM, Noralf Tr?nnes wrote:
> Add a duplicate irq range with an offset on the hwirq's so the
> driver can detect that enable_fiq() is used.
> Tested with downstream dwc_otg USB controller driver.

This basically looks OK, but a few comments/thoughts:

a) Should the Kconfig change be a separate patch since it's a separate
subsystem?

b) Doesn't the driver need to refuse some operation (handler
registration, IRQ setup, IRQ enable, ...?) for more than 1 IRQ in the
FIQ range, since the FIQ control register only allows routing 1 IRQ to FIQ.

c) The DT binding needs updating to describe the extra IRQs:

> Documentation/devicetree/bindings/interrupt-controller/brcm,bcm28armctrl-ic.txt

d) I wonder how the FIQ handler actually gets routed to this controller
and hooked to its handler etc. I assume there's a separate patch for
that coming?

BTW, I'll be on vacation for just over a couple weeks starting Saturday,
so responses will certainly be delayed for a quite a while.
