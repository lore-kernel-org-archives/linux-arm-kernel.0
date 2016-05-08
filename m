From: marex@denx.de (Marek Vasut)
Date: Sun,  8 May 2016 22:50:19 +0200
Subject: [PATCH 2/4] ARM: mxs: dts: Add AUART2 pinmux
In-Reply-To: <1462740621-7557-1-git-send-email-marex@denx.de>
References: <1462740621-7557-1-git-send-email-marex@denx.de>
Message-ID: <1462740621-7557-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marek.vasut@gmail.com>

Add 2-pin pinmux settings for AUART2.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx23.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index c70ebef..0c9a357e 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -171,6 +171,17 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				auart1_2pins_a: auart1-2pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX23_PAD_GPMI_D14__AUART2_RX
+						MX23_PAD_GPMI_D15__AUART2_TX
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
 				gpmi_pins_a: gpmi-nand at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
2.7.0
