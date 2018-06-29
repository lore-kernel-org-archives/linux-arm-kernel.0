From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 29 Jun 2018 10:20:28 +0800
Subject: [PATCH 2/5] dt-bindings: phy-mtk-tphy: add optional properties for
 u2phy
In-Reply-To: <54260d59ae39c2335e97892fe85db16cac30b33b.1530238400.git.chunfeng.yun@mediatek.com>
References: <54260d59ae39c2335e97892fe85db16cac30b33b.1530238400.git.chunfeng.yun@mediatek.com>
Message-ID: <86d49766059a738e7182a49e6c113a12403b3b01.1530238400.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some optional properties for eye diagram test and BC12 of
u2phy

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
index 0d34b2b..a5f7a4f 100644
--- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
@@ -47,6 +47,12 @@ Required properties (port (child) node):
 			- PHY_TYPE_PCIE
 			- PHY_TYPE_SATA
 
+Optional properties (PHY_TYPE_USB2 port (child) node):
+- mediatek,eye-src	: u32, the value of slew rate calibrate
+- mediatek,eye-vrt	: u32, the selection of VRT reference voltage
+- mediatek,eye-term	: u32, the selection of HS_TX TERM reference voltage
+- mediatek,bc12	: bool, enable BC12 of u2phy if support it
+
 Example:
 
 u3phy: usb-phy at 11290000 {
-- 
1.9.1
