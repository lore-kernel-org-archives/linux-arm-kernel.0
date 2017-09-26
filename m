From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 26 Sep 2017 10:02:57 +0800
Subject: [PATCH v2 06/10] arm: dts: mt7623: add subsystem clock controller
 nodes
In-Reply-To: <cover.1506390597.git.ryder.lee@mediatek.com>
References: <cover.1506390597.git.ryder.lee@mediatek.com>
Message-ID: <ea2ed1f558c5f77f533894a90cae3ca5af3df523.1506390597.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing susbsystem clock controllers nodes for MT7623.
(e.g., mmsys, imgsys, vdecsys and bdpsys)

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 9ec3767..ca672bd 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -661,6 +661,30 @@
 		status = "disabled";
 	};
 
+	mmsys: syscon at 14000000 {
+		compatible = "mediatek,mt7623-mmsys",
+			     "mediatek,mt2701-mmsys",
+			     "syscon";
+		reg = <0 0x14000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	imgsys: syscon at 15000000 {
+		compatible = "mediatek,mt7623-imgsys",
+			     "mediatek,mt2701-imgsys",
+			     "syscon";
+		reg = <0 0x15000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	vdecsys: syscon at 16000000 {
+		compatible = "mediatek,mt7623-vdecsys",
+			     "mediatek,mt2701-vdecsys",
+			     "syscon";
+		reg = <0 0x16000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
 	hifsys: syscon at 1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
 			     "mediatek,mt2701-hifsys",
@@ -799,4 +823,12 @@
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
 		status = "disabled";
 	};
+
+	bdpsys: syscon at 1c000000 {
+		compatible = "mediatek,mt7623-bdpsys",
+			     "mediatek,mt2701-bdpsys",
+			     "syscon";
+		reg = <0 0x1c000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
 };
-- 
1.9.1
