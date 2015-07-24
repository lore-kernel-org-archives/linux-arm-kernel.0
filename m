From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 24 Jul 2015 11:02:05 +0800
Subject: [PATCH v4 7/7] arm64: dts: mt8173: Add subsystem clock controller
 device nodes
In-Reply-To: <1437706925-3222-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1437706925-3222-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1437706925-3222-8-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device nodes providing subsystem clocks on MT8173,
includes mmsys, imgsys, vdecsys, vencsys and vencltsys.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index a2f63e4..8731d24 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -88,6 +88,13 @@
 		#clock-cells = <0>;
 	};
 
+	cpum_ck: dummy_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "cpum_ck";
+	};
+
 	clk26m: oscillator at 0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -227,6 +234,36 @@
 			clocks = <&uart_clk>;
 			status = "disabled";
 		};
+
+		mmsys: clock-controller at 14000000 {
+			compatible = "mediatek,mt8173-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys: clock-controller at 15000000 {
+			compatible = "mediatek,mt8173-imgsys", "syscon";
+			reg = <0 0x15000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdecsys: clock-controller at 16000000 {
+			compatible = "mediatek,mt8173-vdecsys", "syscon";
+			reg = <0 0x16000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vencsys: clock-controller at 18000000 {
+			compatible = "mediatek,mt8173-vencsys", "syscon";
+			reg = <0 0x18000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vencltsys: clock-controller at 19000000 {
+			compatible = "mediatek,mt8173-vencltsys", "syscon";
+			reg = <0 0x19000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 };
 
-- 
1.8.1.1.dirty
