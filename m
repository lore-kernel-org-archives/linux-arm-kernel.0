From: petr@barix.com (Petr Kulhavy)
Date: Mon,  2 May 2016 15:40:38 +0200
Subject: [PATCH 1/2] ARM: DTS: da850: add pinmux configuration for mmc1
Message-ID: <1462196439-4693-1-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da850.dtsi defined a pinmux configuration only for MMC0
and not for MMC1.
This adds a (4-bit) pinmux configuration for MMC1.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
 arch/arm/boot/dts/da850.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 226cda76e77c..4983b3d0be55 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -72,6 +72,22 @@
 					0x28 0x00222222  0x00ffffff
 				>;
 			};
+			mmc1_pins: pinmux_mmc1_pins {
+				pinctrl-single,bits = <
+					/*
+					 * PINMUX18:
+					 * MMCSD1_CMD MMCSD1_CLK
+					 * MMCSD0_DAT[0]
+					 */
+					0x48 0x00022200  0x000fff00
+					/*
+					 * PINMUX19:
+					 * MMCSD0_DAT[1] MMCSD0_DAT[2]
+					 * MMCSD0_DAT[3]
+					 */
+					0x4c 0x00022200  0x000fff00
+				>;
+			};
 			ehrpwm0a_pins: pinmux_ehrpwm0a_pins {
 				pinctrl-single,bits = <
 					/* EPWM0A */
-- 
1.9.1
