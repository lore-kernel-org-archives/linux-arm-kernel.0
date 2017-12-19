From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:33 +0100
Subject: [PATCH 09/45] ARM: dts: at91: foxg20: use TCB0 as timers
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-10-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 for timers as selected in at91_dt_defconfig.

Cc: Sergio Tanzilli <tanzilli@acmesystems.it>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-foxg20.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-foxg20.dts b/arch/arm/boot/dts/at91-foxg20.dts
index 50d5e719b451..d413e2d9abdf 100644
--- a/arch/arm/boot/dts/at91-foxg20.dts
+++ b/arch/arm/boot/dts/at91-foxg20.dts
@@ -34,6 +34,18 @@
 
 	ahb {
 		apb {
+			tcb0: timer at fffa0000 {
+				timer at 0 {
+					compatible = "atmel,tcb-timer";
+					reg = <0>, <1>;
+				};
+
+				timer at 2 {
+					compatible = "atmel,tcb-timer";
+					reg = <2>;
+				};
+			};
+
 			usb1: gadget at fffa4000 {
 				atmel,vbus-gpio = <&pioC 6 GPIO_ACTIVE_HIGH>;
 				status = "okay";
-- 
2.15.1
