From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:26:06 +0800
Subject: [PATCH v2 22/30] arm: dts: mt7623: add thermal nodes to the
 mt7623.dtsi file
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-23-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add thermal nodes to the mt7623.dtsi file.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 2289232..d33d535 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -354,6 +354,22 @@
 		status = "disabled";
 	};
 
+	thermal: thermal at 1100b000 {
+		#thermal-sensor-cells = <1>;
+		compatible = "mediatek,mt7623-thermal",
+			     "mediatek,mt2701-thermal";
+		reg = <0 0x1100b000 0 0x1000>;
+		interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
+		clock-names = "therm", "auxadc";
+		resets = <&pericfg MT2701_PERI_THERM_SW_RST>;
+		reset-names = "therm";
+		mediatek,auxadc = <&auxadc>;
+		mediatek,apmixedsys = <&apmixedsys>;
+		nvmem-cells = <&thermal_calibration_data>;
+		nvmem-cell-names = "calibration-data";
+	};
+
 	spi1: spi at 11016000 {
 		compatible = "mediatek,mt7623-spi",
 			     "mediatek,mt2701-spi";
-- 
1.9.1
