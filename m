From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 7 Mar 2017 14:57:21 +0800
Subject: [PATCH 2/2] usb: xhci-mtk: fix checkpatch warning and erorr
In-Reply-To: <1488869841-9959-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1488869841-9959-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1488869841-9959-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

there are two warnings and a erorr when checked by checkpatch.pl
as following:

WARNING:BLOCK_COMMENT_STYLE: Block comments should align
the * on each line

ERROR:COMPLEX_MACRO: Macros with complex values should be
enclosed in parentheses

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 9636884..22c94fe 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -287,9 +287,9 @@ static void usb_wakeup_ip_sleep_dis(struct xhci_hcd_mtk *mtk)
 }
 
 /*
-* for line-state wakeup mode, phy's power should not power-down
-* and only support cable plug in/out
-*/
+ * for line-state wakeup mode, phy's power should not power-down
+ * and only support cable plug in/out
+ */
 static void usb_wakeup_line_state_en(struct xhci_hcd_mtk *mtk)
 {
 	u32 tmp;
@@ -350,10 +350,10 @@ static int usb_wakeup_of_property_parse(struct xhci_hcd_mtk *mtk,
 	struct device *dev = mtk->dev;
 
 	/*
-	* wakeup function is optional, so it is not an error if this property
-	* does not exist, and in such case, no need to get relative
-	* properties anymore.
-	*/
+	 * wakeup function is optional, so it is not an error if this property
+	 * does not exist, and in such case, no need to get relative
+	 * properties anymore.
+	 */
 	of_property_read_u32(dn, "mediatek,wakeup-src", &mtk->wakeup_src);
 	if (!mtk->wakeup_src)
 		return 0;
@@ -796,7 +796,7 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
 static const struct dev_pm_ops xhci_mtk_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(xhci_mtk_suspend, xhci_mtk_resume)
 };
-#define DEV_PM_OPS IS_ENABLED(CONFIG_PM) ? &xhci_mtk_pm_ops : NULL
+#define DEV_PM_OPS (IS_ENABLED(CONFIG_PM) ? &xhci_mtk_pm_ops : NULL)
 
 #ifdef CONFIG_OF
 static const struct of_device_id mtk_xhci_of_match[] = {
-- 
1.7.9.5
