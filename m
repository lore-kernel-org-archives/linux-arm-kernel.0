From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 3 Jan 2014 17:42:41 +0530
Subject: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
In-Reply-To: <20140102220101.GA8652@saruman.home>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
 <20131219184815.GU27438@atomide.com> <20131219232153.GE707@saruman.home>
 <20131221005309.GH26054@atomide.com> <20131223173409.GA10536@saruman.home>
 <20140102220101.GA8652@saruman.home>
Message-ID: <52C6A939.70708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[]..

>>> so a bit more work is needed. Maybe also rebase these against
>>> omap-for-v3.14/dt too?
>>
>> Will do.
> 
> Rebased on top of omap-for-v3.14/omap3-board-removal. Patches are on my
> k.org tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git wip/omap-fix-intc

It needs a minor build fix though..

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index b58c5d5..d03b5a3 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -151,7 +151,7 @@ static void omap_mask_ack_irq(struct irq_data *d)
 static void omap_suspend_irq(struct irq_data *d)
 {
        omap_intc_save_context();
-       omap3_intc_prepare_idle();
+       omap_intc_prepare_idle();
 
        /* A pending interrupt would prevent OMAP from entering suspend */
        omap_ack_irq(NULL);

regards,
Rajendra

> 
> cheers
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
