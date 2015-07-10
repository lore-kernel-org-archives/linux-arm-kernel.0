From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 10 Jul 2015 18:00:05 +0800
Subject: [PATCH v3 5/5] arm64: dts: mt8173: Add subsystem clock controller
 device nodes
In-Reply-To: <1436522405-13923-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436522405-13923-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1436522405-13923-6-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device nodes providing subsystem clocks on MT8173,
includes mmsys, imgsys, vdecsys, vencsys and vencltsys.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index a2f63e4..9d74ce5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -227,6 +227,36 @@
 			clocks = <&uart_clk>;
 			status = "disabled";
 		};
+
+		mmsys: mmsys at 14000000 {
+			compatible = "mediatek,mt8173-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys: imgsys at 15000000 {
+			compatible = "mediatek,mt8173-imgsys", "syscon";
+			reg = <0 0x15000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdecsys: vdecsys at 16000000 {
+			compatible = "mediatek,mt8173-vdecsys", "syscon";
+			reg = <0 0x16000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vencsys: vencsys at 18000000 {
+			compatible = "mediatek,mt8173-vencsys", "syscon";
+			reg = <0 0x18000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vencltsys: vencltsys at 19000000 {
+			compatible = "mediatek,mt8173-vencltsys", "syscon";
+			reg = <0 0x19000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 };
 
-- 
1.8.1.1.dirty
