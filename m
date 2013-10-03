From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  3 Oct 2013 21:04:42 +0200
Subject: [PATCH v4 3/4] ARM: at91/dt: add sam9 watchdog default options to SoCs
In-Reply-To: <1380827083-6872-1-git-send-email-b.brezillon@overkiz.com>
References: <1380827083-6872-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1380827083-6872-4-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set default watchdog options in every SoC compatible with the sam9 watchdog.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |    5 +++++
 arch/arm/boot/dts/at91sam9263.dtsi |    5 +++++
 arch/arm/boot/dts/at91sam9g45.dtsi |    5 +++++
 arch/arm/boot/dts/at91sam9n12.dtsi |    5 +++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |    5 +++++
 arch/arm/boot/dts/sama5d3.dtsi     |    5 +++++
 6 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 56ee828..997901f 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -648,6 +648,11 @@
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				atmel,watchdog-type = "hardware";
+				atmel,reset-type = "all";
+				atmel,dbg-halt;
+				atmel,idle-halt;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index d5bd65f..45fb0a4 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -523,6 +523,11 @@
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				atmel,watchdog-type = "hardware";
+				atmel,reset-type = "all";
+				atmel,dbg-halt;
+				atmel,idle-halt;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index c3e5148..16534c7 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -639,6 +639,11 @@
 			watchdog at fffffd40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				atmel,watchdog-type = "hardware";
+				atmel,reset-type = "all";
+				atmel,dbg-halt;
+				atmel,idle-halt;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 9fb7ffd..eaef94b 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -537,6 +537,11 @@
 			watchdog at fffffe40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				atmel,watchdog-type = "hardware";
+				atmel,reset-type = "all";
+				atmel,dbg-halt;
+				atmel,idle-halt;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index e74dc15..6d31fd7 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -820,6 +820,11 @@
 			watchdog at fffffe40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				atmel,watchdog-type = "hardware";
+				atmel,reset-type = "all";
+				atmel,dbg-halt;
+				atmel,idle-halt;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index b7f4961..3a17a3e 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -891,6 +891,11 @@
 			watchdog at fffffe40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
+				atmel,watchdog-type = "hardware";
+				atmel,reset-type = "all";
+				atmel,dbg-halt;
+				atmel,idle-halt;
 				status = "disabled";
 			};
 
-- 
1.7.9.5
