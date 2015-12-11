From: mans@mansr.com (Mans Rullgard)
Date: Fri, 11 Dec 2015 13:36:26 +0000
Subject: [PATCH] ARM: dts: imx28: add alternate auart4 pinmux
Message-ID: <1449840986-23489-1-git-send-email-mans@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add auart4 2-pin configuration on auart0 rts/cts pads.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/boot/dts/imx28.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index c5b57d4..fae7b90 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -405,6 +405,17 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				auart4_2pins_b: auart4 at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART0_CTS__AUART4_RX
+						MX28_PAD_AUART0_RTS__AUART4_TX
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
 				mac0_pins_a: mac0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
2.6.3
