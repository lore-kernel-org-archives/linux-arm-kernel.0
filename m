From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:26 +0200
Subject: [PATCH 13/40] w1 i.MX: prepare/unprepare clock
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-14-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/w1/masters/mxc_w1.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index a3b6a74..1cc61a7 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -138,7 +138,7 @@ static int __devinit mxc_w1_probe(struct platform_device *pdev)
 		goto failed_ioremap;
 	}
 
-	clk_enable(mdev->clk);
+	clk_prepare_enable(mdev->clk);
 	__raw_writeb(mdev->clkdiv, mdev->regs + MXC_W1_TIME_DIVIDER);
 
 	mdev->bus_master.data = mdev;
@@ -178,7 +178,7 @@ static int __devexit mxc_w1_remove(struct platform_device *pdev)
 
 	iounmap(mdev->regs);
 	release_mem_region(res->start, resource_size(res));
-	clk_disable(mdev->clk);
+	clk_disable_unprepare(mdev->clk);
 	clk_put(mdev->clk);
 
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.9.5
