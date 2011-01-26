From: pma@sysgo.com (Pavel Machek)
Date: Wed, 26 Jan 2011 13:22:16 +0100
Subject: for mainline -- fix pcmcia interrupts
Message-ID: <20110126122216.GA29420@pma.sysgo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


commit 08fa159003aa510027951671b94aadc380ab2d2a
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Sat Dec 26 12:32:38 2009 +0800

    [ARM] sa1111: avoid using hardcoded IRQ numbers for PCMCIA driver

switched ready interrupts for slot 0 and 1 by mistake. Fix that to
make CF work again.

Signed-off-by: Pavel Machek <pma@sysgo.com>

--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -145,8 +145,8 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 		s->soc.socket.owner = ops->owner;
 		s->soc.socket.dev.parent = &dev->dev;
 		s->soc.socket.pci_irq = s->soc.nr ?
-				dev->irq[IDX_IRQ_S0_READY_NINT] :
-				dev->irq[IDX_IRQ_S1_READY_NINT];
+				dev->irq[IDX_IRQ_S1_READY_NINT] :
+				dev->irq[IDX_IRQ_S0_READY_NINT];
 		s->dev = dev;
 
 		ret = add(&s->soc);
