From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri, 21 Jun 2013 09:31:29 +0200
Subject: [PATCH v2 3/4] ARM: at91/dt: add sam9 watchdog default options to SoCs
In-Reply-To: <1371799176-3408-1-git-send-email-b.brezillon@overkiz.com>
References: <1371799176-3408-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1371799889-3812-1-git-send-email-b.brezillon@overkiz.com>
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
index 899a7cf..6c44c35 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -643,6 +643,11 @@
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
index ff63811..6b31ee0 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -519,6 +519,11 @@
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
index faec17d..ca1a643 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -634,6 +634,11 @@
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
index 3166e1d..7c8a5ea 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -505,6 +505,11 @@
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
index e77106e..48eb1cc 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -742,6 +742,11 @@
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
index c00e158..7974723 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -885,6 +885,11 @@
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
