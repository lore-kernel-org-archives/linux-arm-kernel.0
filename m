From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 18 Oct 2015 00:35:56 +0300
Subject: [PATCH v2 7/8] arm: dts: lpc32xx: add device nodes for standard timers
In-Reply-To: <1445117757-8073-1-git-send-email-vz@mleia.com>
References: <1445117757-8073-1-git-send-email-vz@mleia.com>
Message-ID: <1445117757-8073-8-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Zapolskiy <vzy@mleia.com>

NXP LPC32xx SoCs have 6 standard timers, add device nodes to describe
them.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
- none, new change

 arch/arm/boot/dts/lpc32xx.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index a595a4b..ba91b20 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -271,11 +271,31 @@
 				#gpio-cells = <3>; /* bank, pin, flags */
 			};
 
+			timer4: timer at 4002C000 {
+				compatible = "nxp,lpc3220-timer";
+				reg = <0x4002C000 0x1000>;
+				interrupts = <0x3 0>;
+				status = "disabled";
+			};
+
+			timer5: timer at 40030000 {
+				compatible = "nxp,lpc3220-timer";
+				reg = <0x40030000 0x1000>;
+				interrupts = <0x4 0>;
+				status = "disabled";
+			};
+
 			watchdog: watchdog at 4003C000 {
 				compatible = "nxp,pnx4008-wdt";
 				reg = <0x4003C000 0x1000>;
 			};
 
+			timer0: timer at 40044000 {
+				compatible = "nxp,lpc3220-timer";
+				reg = <0x40044000 0x1000>;
+				interrupts = <0x10 0>;
+			};
+
 			/*
 			 * TSC vs. ADC: Since those two share the same
 			 * hardware, you need to choose from one of the
@@ -297,6 +317,12 @@
 				status = "disabled";
 			};
 
+			timer1: timer at 4004C000 {
+				compatible = "nxp,lpc3220-timer";
+				reg = <0x4004C000 0x1000>;
+				interrupts = <0x11 0>;
+			};
+
 			key: key at 40050000 {
 				compatible = "nxp,lpc3220-key";
 				reg = <0x40050000 0x1000>;
@@ -304,6 +330,13 @@
 				status = "disabled";
 			};
 
+			timer2: timer at 40058000 {
+				compatible = "nxp,lpc3220-timer";
+				reg = <0x40058000 0x1000>;
+				interrupts = <0x12 0>;
+				status = "disabled";
+			};
+
 			pwm1: pwm at 4005C000 {
 				compatible = "nxp,lpc3220-pwm";
 				reg = <0x4005C000 0x4>;
@@ -315,6 +348,13 @@
 				reg = <0x4005C004 0x4>;
 				status = "disabled";
 			};
+
+			timer3: timer at 40060000 {
+				compatible = "nxp,lpc3220-timer";
+				reg = <0x40060000 0x1000>;
+				interrupts = <0x13 0>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.1.4
