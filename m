From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Wed, 17 Oct 2012 14:33:13 +0200
Subject: [PATCH v9 2/3] ARM: at91/dts: add at91sam9_wdt driver to at91sam926x,
 at91sam9g45
In-Reply-To: <1350477194-16802-1-git-send-email-fabio.porcedda@gmail.com>
References: <1350477194-16802-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1350477194-16802-3-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on an at91sam9260 board (evk-pro3).

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 6 ++++++
 arch/arm/boot/dts/at91sam9263.dtsi | 6 ++++++
 arch/arm/boot/dts/at91sam9g45.dtsi | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index d410581..bfb5bb6 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -246,6 +246,12 @@
 					trigger-external;
 				};
 			};
+
+			watchdog at fffffd40 {
+				compatible = "atmel,at91sam9260-wdt";
+				reg = <0xfffffd40 0x10>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 3e6e5c1..ff54612 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -195,6 +195,12 @@
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			watchdog at fffffd40 {
+				compatible = "atmel,at91sam9260-wdt";
+				reg = <0xfffffd40 0x10>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 3add030..a98c00a 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -262,6 +262,12 @@
 					trigger-value = <0x6>;
 				};
 			};
+
+			watchdog at fffffd40 {
+				compatible = "atmel,at91sam9260-wdt";
+				reg = <0xfffffd40 0x10>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.11.3
