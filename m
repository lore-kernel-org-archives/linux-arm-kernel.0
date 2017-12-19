From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:39 +0100
Subject: [PATCH 15/45] ARM: dts: at91: at91sam9261ek: use TCB0 as timers
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-16-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 for timers as selected in at91_dt_defconfig.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9261ek.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 960d6940ebf6..35db7f48229a 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -15,6 +15,14 @@
 	chosen {
 		bootargs = "rootfstype=ubifs ubi.mtd=5 root=ubi0:rootfs rw";
 		stdout-path = "serial0:115200n8";
+
+		clocksource {
+			timer = <&timer0>;
+		};
+
+		clockevent {
+			timer = <&timer1>;
+		};
 	};
 
 	memory {
@@ -125,6 +133,18 @@
 		};
 
 		apb {
+			tcb0: timer at fffa0000 {
+				timer0: timer at 0 {
+					compatible = "atmel,tcb-timer";
+					reg = <0>, <1>;
+				};
+
+				timer1: timer at 2 {
+					compatible = "atmel,tcb-timer";
+					reg = <2>;
+				};
+			};
+
 			usb1: gadget at fffa4000 {
 				atmel,vbus-gpio = <&pioB 29 GPIO_ACTIVE_HIGH>;
 				status = "okay";
-- 
2.15.1
