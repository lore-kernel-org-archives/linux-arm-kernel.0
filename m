From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:11 -0300
Subject: [PATCH v3 04/28] ARM: mvebu: Add the core-divider clock to Armada
 370/XP
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370/XP SoC has a clock provider called "Core Divider",
that is derived from a fixed 2 GHz PLL clock.

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 924c721..01e69fc 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -137,6 +137,14 @@
 				status = "disabled";
 			};
 
+			coredivclk: corediv-clock at 18740 {
+				compatible = "marvell,armada-370-corediv-clock";
+				reg = <0x18740 0xc>;
+				#clock-cells = <1>;
+				clocks = <&mainpll>;
+				clock-output-names = "nand";
+			};
+
 			timer at 20300 {
 				reg = <0x20300 0x30>, <0x21040 0x30>;
 				interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
-- 
1.8.1.5
