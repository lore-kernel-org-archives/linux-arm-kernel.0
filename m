From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Tue, 5 Jul 2016 11:50:08 +0800
Subject: [PATCH v2 1/3] dt-bindings: auxadc: Add binding document for Mediatek
 auxadc.
In-Reply-To: <1467690610-20550-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1467690610-20550-1-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <1467690610-20550-2-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit adds the device tree binding documentation for the mediatek
auxadc found on Mediatek MT2701.
Thermal gets auxadc sample data by iio device.
So the commit changes auxadc device tree binding documentation from
/soc/mediatek/auxadc.txt to /iio/adc/mt65xx_auxadc.txt.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 .../devicetree/bindings/iio/adc/mt65xx_auxadc.txt  |   27 ++++++++++++++++++++
 .../devicetree/bindings/soc/mediatek/auxadc.txt    |   21 ---------------
 2 files changed, 27 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
 delete mode 100644 Documentation/devicetree/bindings/soc/mediatek/auxadc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
new file mode 100644
index 0000000..47fcd1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
@@ -0,0 +1,27 @@
+* Mediatek AUXADC - Analog to Digital Converter on Mediatek mobile soc (mt65xx/mt81xx/mt27xx)
+===============
+
+The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
+in some Mediatek SoCs which among other things measures the temperatures
+in the SoC. It can be used directly with register accesses, but it is also
+used by thermal controller which reads the temperatures from the AUXADC
+directly via its own bus interface. See
+Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+for the Thermal Controller which holds a phandle to the AUXADC.
+
+Required properties:
+  - compatible: "mediatek,mt2701-auxadc" or "mediatek,mt8173-auxadc"
+  - reg: Address range of the AUXADC unit.
+  - clocks: Should contain a clock specifier for each entry in clock-names
+  - clock-names: Should contain "main".
+  - io-channel-cells: Should be 1, see ../iio-bindings.txt
+
+Example:
+
+auxadc: auxadc at 11001000 {
+	compatible = "mediatek,mt2701-auxadc";
+	reg = <0 0x11001000 0 0x1000>;
+	clocks = <&pericfg CLK_PERI_AUXADC>;
+	clock-names = "main";
+	#io-channel-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt b/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
deleted file mode 100644
index bdb7829..0000000
--- a/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-MediaTek AUXADC
-===============
-
-The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
-in some Mediatek SoCs which among other things measures the temperatures
-in the SoC. It can be used directly with register accesses, but it is also
-used by thermal controller which reads the temperatures from the AUXADC
-directly via its own bus interface. See
-Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
-for the Thermal Controller which holds a phandle to the AUXADC.
-
-Required properties:
-- compatible: Must be "mediatek,mt8173-auxadc"
-- reg: Address range of the AUXADC unit
-
-Example:
-
-auxadc: auxadc at 11001000 {
-	compatible = "mediatek,mt8173-auxadc";
-	reg = <0 0x11001000 0 0x1000>;
-};
-- 
1.7.9.5
