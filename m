From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 23 Mar 2015 15:28:53 +0200
Subject: [PATCH 1/2] rtc: digicolor: document device tree binding
Message-ID: <fa36a31a1d58d626ca0cb01ca0dece85aa2dfcb9.1427117334.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree binding documentation to the Real Time Clock hardware block
on the Conexant CX92755 SoC. The CX92755 is from the Digicolor SoCs series.
Other SoCs in that series may share the same hardware block.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/devicetree/bindings/rtc/digicolor-rtc.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/digicolor-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/digicolor-rtc.txt b/Documentation/devicetree/bindings/rtc/digicolor-rtc.txt
new file mode 100644
index 000000000000..d464986012cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/digicolor-rtc.txt
@@ -0,0 +1,17 @@
+Conexant Digicolor Real Time Clock controller
+
+This binding currently supports the CX92755 SoC.
+
+Required properties:
+- compatible: should be "cnxt,cx92755-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: rtc alarm interrupt
+
+Example:
+
+	rtc at f0000c30 {
+		compatible = "cnxt,cx92755-rtc";
+		reg = <0xf0000c30 0x18>;
+		interrupts = <25>;
+	};
-- 
2.1.4
