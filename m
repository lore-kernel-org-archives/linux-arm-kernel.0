From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 26 Mar 2018 18:03:36 +0800
Subject: [PATCH] usb: xhci-mtk: remove redundant MODULE_ALIAS entries
Message-ID: <9b7cc59683fc4d1d2b03419cec4b440d5d949114.1522055042.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

MODULE_ALIAS exports information to allow the module to be auto-loaded at
boot for the drivers registered using legacy platform registration.

However, currently the driver is always used by DT-only platform,
MODULE_ALIAS is redundant and should be removed properly.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index b0ab4d5..2807c769 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -766,7 +766,6 @@ static struct platform_driver mtk_xhci_driver = {
 		.of_match_table = of_match_ptr(mtk_xhci_of_match),
 	},
 };
-MODULE_ALIAS("platform:xhci-mtk");
 
 static int __init xhci_mtk_init(void)
 {
-- 
2.7.4
