From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 13 Apr 2014 09:19:05 +0400
Subject: [PATCH 02/10] ARM: dts: imx51-babbage: Use separate pingroup for
 fixed-clock
In-Reply-To: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
References: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
Message-ID: <1397366353-29395-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves GPIOs definitions for "fixed-clock" into a separate
pingroup.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index eddb62d..651a8c8 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -125,6 +125,8 @@
 
 		clk_26M: codec_clock {
 			compatible = "fixed-clock";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_clkcodec>;
 			reg=<0>;
 			#clock-cells = <0>;
 			clock-frequency = <26000000>;
@@ -337,7 +339,6 @@
 				MX51_PAD_GPIO1_6__GPIO1_6    0x100
 				MX51_PAD_CSPI1_SS0__GPIO4_24 0x85
 				MX51_PAD_CSPI1_SS1__GPIO4_25 0x85
-				MX51_PAD_CSPI1_RDY__GPIO4_26 0x80000000
 			>;
 		};
 
@@ -350,6 +351,12 @@
 			>;
 		};
 
+		pinctrl_clkcodec: clkcodecgrp {
+			fsl,pins = <
+				MX51_PAD_CSPI1_RDY__GPIO4_26		0x80000000
+			>;
+		};
+
 		pinctrl_ecspi1: ecspi1grp {
 			fsl,pins = <
 				MX51_PAD_CSPI1_MISO__ECSPI1_MISO	0x185
-- 
1.8.3.2
