From: flora.fu@mediatek.com (Flora Fu)
Date: Fri, 26 Dec 2014 15:09:27 +0800
Subject: [PATCH v4 5/6] arm: dts: mt8135: Add support for MT8135 PMIC wrapper
In-Reply-To: <1419577768-12037-1-git-send-email-flora.fu@mediatek.com>
References: <1419577768-12037-1-git-send-email-flora.fu@mediatek.com>
Message-ID: <1419577768-12037-6-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree for MT8135 PMIC wrapper in mt8135.dtsi.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 arch/arm/boot/dts/mt8135.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index ec83e69..ab08063 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -117,6 +117,20 @@
 			reg = <0 0x10200030 0 0x1c>;
 		};
 
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
+			clocks = <&topckgen TOP_PMICSPI_SEL>, <&clk26m> ;
+			clock-names = "pmicspi-sel", "pmicspi-parent";
+		};
+
 		gic: interrupt-controller at 10211000 {
 			compatible = "arm,cortex-a15-gic";
 			interrupt-controller;
-- 
1.8.1.1.dirty
