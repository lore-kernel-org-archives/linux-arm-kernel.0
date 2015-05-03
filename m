From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 03 May 2015 20:47:02 +0200
Subject: [PATCH v2 0/5] Driver for pxa architectures
In-Reply-To: <20150503152300.GU3521@localhost> (Vinod Koul's message of "Sun,
 3 May 2015 20:53:00 +0530")
References: <1428781236-25806-1-git-send-email-robert.jarzmik@free.fr>
 <87egnf7uqp.fsf@belgarion.home> <87lhhek6dz.fsf@belgarion.home>
 <87egn0jbtf.fsf@belgarion.home> <20150503152300.GU3521@localhost>
Message-ID: <87vbg9v6qh.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

>> Would it be possible that I take that through the pxa tree, even it stays in
>> drivers/dmaengine ? I want that to land in the next cycle, and I'll take the
>> fixes and maintainance anyway on my back.
> Sorry about the delay, I should be able to get this done in next few days
> and if all ggod then it should in next before eow.

Ok, great, that works for me.
Given the size of that patch, I'm expecting to release a v3/v4 after your
comments.

If not, you should be aware that I have a local patch on patch 3/5 in [1].

-- 
Robert

[1]
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 9f80d51..5295fb7 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1293,7 +1293,7 @@ static int pxad_init_phys(struct platform_device *op,
 			ret = devm_request_irq(&op->dev, irq,
 					       pxad_chan_handler,
 					       IRQF_SHARED, "pxa-dma", phy);
-		if ((nr_irq == 1) && (irq == 0))
+		if ((nr_irq == 1) && (i == 0))
 			ret = devm_request_irq(&op->dev, irq0,
 					       pxad_int_handler,
 					       IRQF_SHARED, "pxa-dma", pdev);
