From: carlo.caione@gmail.com (Carlo Caione)
Date: Wed, 16 Oct 2013 20:30:26 +0200
Subject: [PATCH v2 1/2] ARM: dts: sun4i/sun7i: add RTC node
Message-ID: <1381948227-6290-1-git-send-email-carlo.caione@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the RTC node to DTS for Allwinner A10 and Allwinner A20.

Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
---
v1->v2:
- changed string "compatible" in sun4i-a10.dtsi
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 6 ++++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index c32770a..26b0519 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -266,6 +266,12 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		rtc: rtc at 01c20d00 {
+			compatible = "allwinner,sun4i-rtc";
+			reg = <0x01c20d00 0x20>;
+			interrupts = <24>;
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 80559cb..12160d8 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -244,6 +244,12 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		rtc: rtc at 01c20d00 {
+			compatible = "allwinner,sun7i-a20-rtc";
+			reg = <0x01c20d00 0x20>;
+			interrupts = <0 24 1>;
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
1.8.4.1
