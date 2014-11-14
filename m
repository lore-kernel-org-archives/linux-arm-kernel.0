From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 14 Nov 2014 11:08:49 +0100
Subject: [PATCH 1/4] ARM: at91/dt: add RTT nodes to at91 dtsis
In-Reply-To: <1415959732-13591-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415959732-13591-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415959732-13591-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91sam926x, at91sam9g45 and at91sam9rl SoCs all have at least one RTT
block.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |  8 ++++++++
 arch/arm/boot/dts/at91sam9261.dtsi |  8 ++++++++
 arch/arm/boot/dts/at91sam9263.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |  8 ++++++++
 arch/arm/boot/dts/at91sam9rl.dtsi  |  8 ++++++++
 5 files changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index cb100b0..9ea824e 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -956,6 +956,14 @@
 				};
 			};
 
+			rtc at fffffd20 {
+				compatible = "atmel,at91sam9260-rtt";
+				reg = <0xfffffd20 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
+				status = "disabled";
+			};
+
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index a81aab4..06b11fc 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -828,6 +828,14 @@
 				clocks = <&mck>;
 			};
 
+			rtc at fffffd20 {
+				compatible = "atmel,at91sam9260-rtt";
+				reg = <0xfffffd20 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&slow_xtal>;
+				status = "disabled";
+			};
+
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 653e439..7f37b7e 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -922,6 +922,21 @@
 				pinctrl-0 = <&pinctrl_can_rx_tx>;
 				clocks = <&can_clk>;
 				clock-names = "can_clk";
+			};
+
+			rtc at fffffd20 {
+				compatible = "atmel,at91sam9260-rtt";
+				reg = <0xfffffd20 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&slow_xtal>;
+				status = "disabled";
+			};
+
+			rtc at fffffd50 {
+				compatible = "atmel,at91sam9260-rtt";
+				reg = <0xfffffd50 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&slow_xtal>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index d3f6513..3771088 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1192,6 +1192,14 @@
 				};
 			};
 
+			rtc at fffffd20 {
+				compatible = "atmel,at91sam9260-rtt";
+				reg = <0xfffffd20 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
+				status = "disabled";
+			};
+
 			rtc at fffffdb0 {
 				compatible = "atmel,at91rm9200-rtc";
 				reg = <0xfffffdb0 0x30>;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index f0b4352..6d77b02 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -1059,6 +1059,14 @@
 					clocks = <&slow_rc_osc &slow_osc>;
 				};
 			};
+
+			rtc at fffffd20 {
+				compatible = "atmel,at91sam9260-rtt";
+				reg = <0xfffffd20 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
+				status = "disabled";
+			};
 		};
 	};
 
-- 
1.9.1
