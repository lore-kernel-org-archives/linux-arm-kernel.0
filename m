From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 12 Mar 2014 18:17:03 +0100
Subject: [PATCH v2 0/4] irq: sun4i IRQ 0 / ENMI fixes
Message-ID: <1394644627-12315-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v2 of my sun4i IRQ 0 / ENMI fixes fixes, changelog below:

v2:

PATCH 1/4 irq: Add handle_fasteoi_late_irq irq handler
New patch by Thomas Gleixner, adding a new irq handler with the "call eoi
after the irq-handler has run its course" behavior we need to avoid double
irqs on the ENMI.

PATCH 2/4 irqchip: sun4i: Fix irq 0 not working
Modified to avoid spurious calls to the irq 0 handler, as suggested by Maxime.

PATCH 3/4 irqchip: sun4i: Fix a comment about mask register
Added Maxime's Acked-by

PATCH 4/4 irqchip: sun4i: Use handle_fasteoi_late_irq for the
New patch switching the handler for irq 0 over to the new
handle_fasteoi_late_irq handler, thereby fixing the double interrupts issue

Thanks for all the help to all involved.

Regards,

Hans
