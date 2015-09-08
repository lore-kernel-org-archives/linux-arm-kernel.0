From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Tue, 8 Sep 2015 22:41:37 +0000
Subject: question about DOMAIN_BUS_ANY
Message-ID: <CY1PR0301MB07485D964A46A10E1F80154D87530@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

Have a question about DOMAIN_BUS_ANY.  Based on your comment in 
include/linux/irqdomain.h:

  /*
   * Should several domains have the same device node, but serve
   * different purposes (for example one domain is for PCI/MSI, and the
   * other for wired IRQs), they can be distinguished using a
   * bus-specific token. Most domains are expected to only carry
   * DOMAIN_BUS_ANY.
   */

...if there are 2 domains that are based on the same GIC ITS node,
for example PCI and the new Freescale "fsl-mc" bus, we should
be extending irq_domain_bus_token with a new token, correct?

The reason "most" domains are expected to have BUS_ANY is because
most domains have 1 associated device node and there is no ambiguity,
right?

Currently the fsl-mc bus driver is in drivers/staging.  Is that
an issue with respect to extending the enum?  (not 100% sure
what the rules are regarding drivers in staging and other
dependencies like this enum which are outside of staging).

Another related question... we are implementing a fsl-mc
bus specific support in a irq-gic-v3-its-fsl-mc-msi.c file,
similar to what you did for PCI and platform buses.  Do you
want to see that file in drivers/staging for now, or should
we put it under drivers/irqchip?

Thanks,
Stuart
