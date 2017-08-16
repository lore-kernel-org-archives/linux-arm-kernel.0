From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 16 Aug 2017 14:08:11 +0800
Subject: [PATCH v2 2/4] usb: xhci-mtk: add generic compatible string
In-Reply-To: <670f9ce1ecaec5859006b6f02b45cfc72c3cca2c.1502854628.git.chunfeng.yun@mediatek.com>
References: <670f9ce1ecaec5859006b6f02b45cfc72c3cca2c.1502854628.git.chunfeng.yun@mediatek.com>
Message-ID: <33fa448238c0d95f0cfd6c2be3bd5c4e657a0cd4.1502854628.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xhci-mtk driver is a generic driver for MediaTek xHCI IP, add
a generic compatible to avoid confusion when support new SoCs but
use a compatible with specific SoC's name "mt8173".

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 67d5dc7..8fb6065 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -795,6 +795,7 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
 #ifdef CONFIG_OF
 static const struct of_device_id mtk_xhci_of_match[] = {
 	{ .compatible = "mediatek,mt8173-xhci"},
+	{ .compatible = "mediatek,mtk-xhci"},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_xhci_of_match);
-- 
1.7.9.5
