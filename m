From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 29 Jun 2011 20:00:16 +0200
Subject: [PATCH 2/5] ASoC: atmel-ssc: add phybase in device structure
In-Reply-To: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
References: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <a128473d585314a01420a5869949065a549119e3.1309368631.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Useful for future dmaengine use.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/misc/atmel-ssc.c  |    1 +
 include/linux/atmel-ssc.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index 4afffe6..27c9ffa 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -101,6 +101,7 @@ static int __init ssc_probe(struct platform_device *pdev)
 		retval = -EINVAL;
 		goto out_clk;
 	}
+	ssc->phybase = regs->start;
 
 	/* disable all interrupts */
 	clk_enable(ssc->clk);
diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
index 0602339..2bab4b4 100644
--- a/include/linux/atmel-ssc.h
+++ b/include/linux/atmel-ssc.h
@@ -6,6 +6,7 @@
 
 struct ssc_device {
 	struct list_head	list;
+	resource_size_t		phybase;
 	void __iomem		*regs;
 	struct platform_device	*pdev;
 	struct clk		*clk;
-- 
1.7.3
