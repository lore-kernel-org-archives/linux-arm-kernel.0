From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Mon, 20 Nov 2017 20:08:30 +0100
Subject: [PATCH] ARM: dts: imx6qdl-udoo: disable AC'97 input pins pad drivers
Message-ID: <94862a4d-bec5-cf19-95e6-512d88dd07dc@maciej.szmigiero.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AC'97 interface RXD and TXC pins are only used as SoC inputs, let's disable
pad drivers for them so we will be protected if, for example, TCLKDIR is
set by mistake in AUDMUX and causes TXC pin to be configured as an output.

This also changes pull direction on these pins from pull-up to pull-down
to match what the board AC'97 CODEC chip (VT1613) has on these pins.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index a173de20ee73..dd69e8397116 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -199,8 +199,8 @@
 			fsl,pins = <
 				MX6QDL_PAD_DI0_PIN2__AUD6_TXD		0x1b0b0
 				MX6QDL_PAD_DI0_PIN3__AUD6_TXFS		0x1b0b0
-				MX6QDL_PAD_DI0_PIN4__AUD6_RXD		0x1b0b0
-				MX6QDL_PAD_DI0_PIN15__AUD6_TXC		0x1b0b0
+				MX6QDL_PAD_DI0_PIN4__AUD6_RXD		0x13080
+				MX6QDL_PAD_DI0_PIN15__AUD6_TXC		0x13080
 				MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x1b0b0
 			>;
 		};
@@ -209,8 +209,8 @@
 			fsl,pins = <
 				MX6QDL_PAD_DI0_PIN2__AUD6_TXD		0x1b0b0
 				MX6QDL_PAD_DI0_PIN3__GPIO4_IO19		0x1b0b0
-				MX6QDL_PAD_DI0_PIN4__AUD6_RXD		0x1b0b0
-				MX6QDL_PAD_DI0_PIN15__AUD6_TXC		0x1b0b0
+				MX6QDL_PAD_DI0_PIN4__AUD6_RXD		0x13080
+				MX6QDL_PAD_DI0_PIN15__AUD6_TXC		0x13080
 				MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x1b0b0
 			>;
 		};
@@ -219,8 +219,8 @@
 			fsl,pins = <
 				MX6QDL_PAD_DI0_PIN2__GPIO4_IO18		0x1b0b0
 				MX6QDL_PAD_DI0_PIN3__GPIO4_IO19		0x1b0b0
-				MX6QDL_PAD_DI0_PIN4__AUD6_RXD		0x1b0b0
-				MX6QDL_PAD_DI0_PIN15__AUD6_TXC		0x1b0b0
+				MX6QDL_PAD_DI0_PIN4__AUD6_RXD		0x13080
+				MX6QDL_PAD_DI0_PIN15__AUD6_TXC		0x13080
 				MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x1b0b0
 			>;
 		};
-- 
2.14.1
