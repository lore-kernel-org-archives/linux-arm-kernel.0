From: erin.lo@mediatek.com (Erin Lo)
Date: Mon, 26 Jun 2017 15:51:30 +0800
Subject: [PATCH v3 2/4] arm: dts: mt2701: Add display bls related nodes for
 MT2701
In-Reply-To: <1498463492-24633-1-git-send-email-erin.lo@mediatek.com>
References: <1498463492-24633-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1498463492-24633-3-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Weiqing Kong <weiqing.kong@mediatek.com>

This patch adds the device node of display backlight for MT2701

Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 91ed40d..8e574a0 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -366,6 +366,15 @@
 		#clock-cells = <1>;
 	};
 
+	bls: bls at 1400a000 {
+		compatible = "mediatek,mt2701-disp-pwm";
+		reg = <0 0x1400a000 0 0x1000>;
+		#pwm-cells = <2>;
+		clocks = <&mmsys CLK_MM_MDP_BLS_26M>, <&mmsys CLK_MM_DISP_BLS>;
+		clock-names = "main", "mm";
+		status = "disabled";
+	};
+
 	larb0: larb at 14010000 {
 		compatible = "mediatek,mt2701-smi-larb";
 		reg = <0 0x14010000 0 0x1000>;
-- 
1.9.1
