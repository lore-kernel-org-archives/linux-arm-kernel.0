From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  1 Jul 2011 16:46:37 +0200
Subject: [PATCH V2 2/5] ASoC: atmel-ssc: add phybase in device structure
In-Reply-To: <20110629174822.GB13051@opensource.wolfsonmicro.com>
References: <20110629174822.GB13051@opensource.wolfsonmicro.com>
Message-ID: <1309531597-2008-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Useful for future dmaengine use.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
V2: change type to phys_addr_t.

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
index 0602339..6ff634e 100644
--- a/include/linux/atmel-ssc.h
+++ b/include/linux/atmel-ssc.h
@@ -6,6 +6,7 @@
 
 struct ssc_device {
 	struct list_head	list;
+	phys_addr_t		phybase;
 	void __iomem		*regs;
 	struct platform_device	*pdev;
 	struct clk		*clk;
-- 
1.7.3
