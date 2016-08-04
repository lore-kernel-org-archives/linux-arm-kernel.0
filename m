From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:12 +0200
Subject: [PATCH v2 09/17] ARM: dts: mvebu: armada-39x: enable watchdog for all
 Armada-39x SoCs
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-10-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The whole Armada 39x SoC family of processors has watchdog which can be
supported with existing driver.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Reviewed-by: Lior Amsalem <alior@marvell.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-39x.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index 03dc0ec..5e01438 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -322,6 +322,14 @@
 				clock-names = "nbclk", "fixed";
 			};
 
+			watchdog at 20300 {
+				compatible = "marvell,armada-380-wdt";
+				reg = <0x20300 0x34>, <0x20704 0x4>,
+				      <0x18260 0x4>;
+				clocks = <&coreclk 2>, <&refclk>;
+				clock-names = "nbclk", "fixed";
+			};
+
 			cpurst at 20800 {
 				compatible = "marvell,armada-370-cpu-reset";
 				reg = <0x20800 0x10>;
@@ -534,5 +542,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <1000000000>;
 		};
+
+		/* 25 MHz reference crystal */
+		refclk: oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+		};
 	};
 };
-- 
1.8.3.1
