From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 7 Mar 2017 11:32:23 +0800
Subject: [PATCH 2/2] usb: xhci: remove dummy extra_priv_size for size of
 xhci_hcd struct
In-Reply-To: <1488857543-9384-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1488857543-9384-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1488857543-9384-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

because hcd_priv_size is already size of xhci_hcd struct,
extra_priv_size is not needed anymore for MTK and tegra drivers.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c   |    1 -
 drivers/usb/host/xhci-tegra.c |    1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 6ac73a6..67d5dc7 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -382,7 +382,6 @@ static int usb_wakeup_of_property_parse(struct xhci_hcd_mtk *mtk,
 
 static int xhci_mtk_setup(struct usb_hcd *hcd);
 static const struct xhci_driver_overrides xhci_mtk_overrides __initconst = {
-	.extra_priv_size = sizeof(struct xhci_hcd),
 	.reset = xhci_mtk_setup,
 };
 
diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index a59fafb..74436f8 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1308,7 +1308,6 @@ static int tegra_xhci_setup(struct usb_hcd *hcd)
 }
 
 static const struct xhci_driver_overrides tegra_xhci_overrides __initconst = {
-	.extra_priv_size = sizeof(struct xhci_hcd),
 	.reset = tegra_xhci_setup,
 };
 
-- 
1.7.9.5
