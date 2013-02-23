From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 23 Feb 2013 18:35:58 +0100
Subject: [PATCH 2/2] Drivers: w1: mxc_w1, Add driver owner
In-Reply-To: <1361640958-1876-1-git-send-email-mpa@pengutronix.de>
References: <1361640958-1876-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1361640958-1876-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver owner was missing.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/w1/masters/mxc_w1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index 827ff7f..7589970 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -195,6 +195,7 @@ MODULE_DEVICE_TABLE(of, mxc_w1_of_ids);
 static struct platform_driver mxc_w1_driver = {
 	.driver = {
 		   .name = "mxc_w1",
+		   .owner = THIS_MODULE,
 		   .of_match_table = mxc_w1_of_ids,
 	},
 	.probe = mxc_w1_probe,
-- 
1.8.1.2
