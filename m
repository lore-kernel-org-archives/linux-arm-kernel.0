From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:26:05 +0800
Subject: [PATCH v2 21/30] arm: dts: mt7623: add efuse nodes to the mt7623.dtsi
 file
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-22-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add efuse nodes to the mt7623.dtsi file.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 0f82e1a..2289232 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -189,6 +189,17 @@
 		reg = <0 0x10200100 0 0x1c>;
 	};
 
+	efuse: efuse at 10206000 {
+		compatible = "mediatek,mt7623-efuse",
+			     "mediatek,mt8173-efuse";
+		reg	   = <0 0x10206000 0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		thermal_calibration_data: calib at 424 {
+			reg = <0x424 0xc>;
+		};
+	};
+
 	apmixedsys: syscon at 10209000 {
 		compatible = "mediatek,mt7623-apmixedsys",
 			     "mediatek,mt2701-apmixedsys",
-- 
1.9.1
