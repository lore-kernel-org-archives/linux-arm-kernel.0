From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri,  1 Feb 2013 15:06:25 +0800
Subject: [PATCH v4 7/8] ARM: dts: add the watchdog nodes for at91sam9x5 and
 at91sam9n12 SoC
In-Reply-To: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
References: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1359702386-21284-8-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux at arm.linux.org.uk
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/at91sam9n12.dtsi |    6 ++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |    6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 80e29c6..8fecdd1 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -381,6 +381,12 @@
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			watchdog at fffffe40 {
+				compatible = "atmel,at91sam9260-wdt";
+				reg = <0xfffffe40 0x10>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 8ecca69..eadba6d 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -511,6 +511,12 @@
 					trigger-value = <0x6>;
 				};
 			};
+
+			watchdog at fffffe40 {
+				compatible = "atmel,at91sam9260-wdt";
+				reg = <0xfffffe40 0x10>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.9.5
