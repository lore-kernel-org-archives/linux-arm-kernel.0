From: xudong.chen@mediatek.com (Xudong Chen)
Date: Tue, 4 Nov 2014 13:29:35 +0800
Subject: [PATCH v2 1/3] dt-bindings: Add I2C bindings for mt65xx/mt81xx.
In-Reply-To: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
References: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
Message-ID: <1415078977-18374-2-git-send-email-xudong.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree bindings for Mediatek Soc I2C driver.

Signed-off-by: Xudong Chen <xudong.chen@mediatek.com>
---
 .../devicetree/bindings/i2c/i2c-mt6577.txt         | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
new file mode 100644
index 0000000..733e65e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
@@ -0,0 +1,39 @@
+* Mediatek's I2C controller
+
+The Mediatek's I2C controller is used to interface with I2C devices.
+
+Required properties:
+  - compatible: value should be either of the following.
+      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
+      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
+      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
+      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
+  - reg: physical base address of the controller and dma base, length of memory mapped
+    region.
+  - interrupts: interrupt number to the cpu.
+  - clock-div: the fixed value for frequency divider of clock source in i2c module.
+    Each IC may be different.
+  - clocks: clock name from clock manager
+  - clock-names: clock name used in i2c driver probe
+
+Optional properties:
+  - clock-frequency: Frequency in Hz of the bus when transfer, the default value is 100000.
+  - mediatek,have-pmic: platform can control i2c form special pmic side.
+    Only mt6589 and mt8135 support this feature.
+  - mediatek,have-dcm: platform has DCM(hardware digital clock manager) property.
+  - mediatek,use-push-pull: IO use push-pull mode.
+
+Example:
+
+	i2c0: i2c at 1100d000 {
+			compatible = "mediatek,mt6577-i2c";
+			reg = <0x1100d000 0x70>,
+			      <0x11000300 0x80>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
+			clock-frequency = <100000>;
+			mediatek,have-pmic;
+			clock-div = <16>;
+			clocks = <&i2c0_ck>, <&ap_dma_ck>;
+			clock-names = "main", "dma";
+	};
+
-- 
1.8.1.1.dirty
