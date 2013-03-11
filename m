From: jhovold@gmail.com (Johan Hovold)
Date: Mon, 11 Mar 2013 19:07:57 +0100
Subject: [PATCH v2 3/5] ARM: at91/dts: add RTT nodes
In-Reply-To: <1363025279-17615-1-git-send-email-jhovold@gmail.com>
References: <20130311180611.GF8797@localhost>
 <1363025279-17615-1-git-send-email-jhovold@gmail.com>
Message-ID: <1363025279-17615-4-git-send-email-jhovold@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RTT nodes for Atmel SOCs.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |  5 +++++
 arch/arm/boot/dts/at91sam9263.dtsi | 10 ++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index cb7bcc5..3a7a8dd 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -462,6 +462,11 @@
 				status = "disabled";
 			};
 
+			rtt at fffffd20 {
+				compatible = "atmel,at91sam9260-rtt";
+				reg = <0xfffffd20 0x10>;
+			};
+
 			ssc0: ssc at fffbc000 {
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfffbc000 0x4000>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 271d4de..3a44382 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -457,6 +457,16 @@
 				status = "disabled";
 			};
 
+			rtt at fffffd20 {
+				compatible = "atmel,at91sam9260-rtt";
+				reg = <0xfffffd20 0x10>;
+			};
+
+			rtt at fffffd50 {
+				compatible = "atmel,at91sam9260-rtt";
+				reg = <0xfffffd50 0x10>;
+			};
+
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index c1ad522..750b696 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -531,6 +531,11 @@
 				reg = <0xfffffdb0 0x30>;
 			};
 
+			rtt at fffffd20 {
+				compatible = "atmel,at91sam9260-rtt";
+				reg = <0xfffffd20 0x10>;
+			};
+
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
-- 
1.8.1.5
