From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Apr 2013 11:59:30 +0200
Subject: [PATCH 18/23] dma: coh901318: add devicetree support
Message-ID: <1366624770-6786-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds support for probing the COH 901 318 DMA controller
from the device tree.

Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Vinod, I'm seeking an ACK on this patch to take it through
the ARM SoC tree.
---
 drivers/dma/coh901318.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 797940e..2855646 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -2758,11 +2758,16 @@ static int __exit coh901318_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id coh901318_dt_match[] = {
+	{ .compatible = "stericsson,coh901318" },
+	{},
+};
 
 static struct platform_driver coh901318_driver = {
 	.remove = __exit_p(coh901318_remove),
 	.driver = {
 		.name	= "coh901318",
+		.of_match_table = coh901318_dt_match,
 	},
 };
 
-- 
1.7.11.3
