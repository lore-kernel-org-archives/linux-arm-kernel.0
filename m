From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 31 Jul 2015 21:03:52 +0800
Subject: [PATCH v4 1/5] dt-bindings: Add usb3.0 phy binding for MT65xx SoCs
In-Reply-To: <1438347836-29060-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1438347836-29060-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1438347836-29060-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a DT binding documentation of usb3.0 phy for MT65xx
SoCs from Mediatek.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/phy/phy-mt65xx-usb.txt      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
new file mode 100644
index 0000000..752abc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
@@ -0,0 +1,21 @@
+MT65xx USB3.0 PHY
+
+The device node for Mediatek SOC usb3.0 phy
+
+Required properties:
+ - compatible : Should be "mediatek,mt8173-u3phy"
+ - reg        : Offset and length of registers for phy domain
+ - clocks     : must support all clocks that phy need
+ - clock-names: should be "u3phya_ref" for u3phya reference clock.
+ - #phy-cells : must be 1 for the phy
+
+Example:
+
+u3phy: usb-phy at 11290000 {
+	compatible = "mediatek,mt8173-u3phy";
+	reg = <0 0x11290000 0 0x3000>;
+	clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
+	clock-names = "u3phya_ref";
+	#phy-cells = <1>;
+	status = "okay";
+};
-- 
1.8.1.1.dirty
