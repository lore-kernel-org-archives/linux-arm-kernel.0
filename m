From: flora.fu@mediatek.com (Flora Fu)
Date: Mon, 17 Nov 2014 15:40:26 +0800
Subject: [PATCH 6/7] ARM: dts: mt8135: Add support for PMIC MT6397 MFD
In-Reply-To: <1416210027-5562-1-git-send-email-flora.fu@mediatek.com>
References: <1416210027-5562-1-git-send-email-flora.fu@mediatek.com>
Message-ID: <1416210027-5562-7-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree for MT6397 MFD and its PMIC wrapper in mt8135.dtsi.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 arch/arm/boot/dts/mt8135.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 90a56ad..14a8aad 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -102,6 +102,25 @@
 			clock-names = "system-clk", "rtc-clk";
 		};
 
+
+		pwrap: pwrap at 1000f000 {
+			compatible = "mediatek,mt8135-pwrap";
+			reg = <0 0x1000f000 0 0x1000>,
+				<0 0x11017000 0 0x1000>;
+			reg-names = "pwrap-base", "pwrap-bridge-base";
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&infrarst MT8135_INFRA_PMIC_WRAP_RST>,
+					<&perirst MT8135_PERI_PWRAP_BRIDGE_SW_RST>;
+			reset-names = "infra-pwrap-rst",
+					"peri-pwrap-bridge-rst";
+			clocks = <&pmicspi_sel>, <&clk26m> ;
+			clock-names = "pmicspi-sel", "pmicspi-parent";
+
+			pmic {
+				compatible = "mediatek,mt6397";
+			};
+		};
+
 		gic: interrupt-controller at 10211000 {
 			compatible = "arm,cortex-a15-gic";
 			interrupt-controller;
-- 
1.8.1.1.dirty
