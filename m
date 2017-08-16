From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 16 Aug 2017 14:08:10 +0800
Subject: [PATCH v2 1/4] usb: mtu3: add generic compatible string
Message-ID: <670f9ce1ecaec5859006b6f02b45cfc72c3cca2c.1502854628.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mtu3 driver is a generic driver for MediaTek usb3 DRD IP, add
a generic compatible to avoid confusion when support new SoCs but
use a compatible with specific SoC's name "mt8173".

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_plat.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 0d3ebb3..088e3e6 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -500,6 +500,7 @@ static int __maybe_unused mtu3_resume(struct device *dev)
 
 static const struct of_device_id mtu3_of_match[] = {
 	{.compatible = "mediatek,mt8173-mtu3",},
+	{.compatible = "mediatek,mtu3",},
 	{},
 };
 
-- 
1.7.9.5
