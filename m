From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:05:07 +0100
Subject: [PATCH 29/30] dma: mv_xor: add missing __devinit and __devexit
 qualifiers on probe and remove
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-30-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ->probe() and ->remove() functions were missing the usual
__devinit and __devexit qualifiers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index b1c4edd..97c8611f 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1233,7 +1233,7 @@ mv_xor_conf_mbus_windows(struct mv_xor_device *xordev,
 	writel(win_enable, base + WINDOW_BAR_ENABLE(1));
 }
 
-static int mv_xor_probe(struct platform_device *pdev)
+static int __devinit mv_xor_probe(struct platform_device *pdev)
 {
 	const struct mbus_dram_target_info *dram;
 	struct mv_xor_device *xordev;
@@ -1358,7 +1358,7 @@ err_channel_add:
 	return ret;
 }
 
-static int mv_xor_remove(struct platform_device *pdev)
+static int __devexit mv_xor_remove(struct platform_device *pdev)
 {
 	struct mv_xor_device *xordev = platform_get_drvdata(pdev);
 	int i;
@@ -1386,7 +1386,7 @@ MODULE_DEVICE_TABLE(of, mv_xor_dt_ids);
 
 static struct platform_driver mv_xor_driver = {
 	.probe		= mv_xor_probe,
-	.remove		= mv_xor_remove,
+	.remove		= __devexit_p(mv_xor_remove),
 	.driver		= {
 		.owner	        = THIS_MODULE,
 		.name	        = MV_XOR_NAME,
-- 
1.7.9.5
