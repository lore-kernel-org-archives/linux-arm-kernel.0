From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:52 +0100
Subject: [PATCH 28/45] ARM: dts: at91: acme/g25: use TCB0 as timers
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-29-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 for timers as selected in at91_dt_defconfig.

Cc: Sergio Tanzilli <tanzilli@acmesystems.it>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-ariag25.dts    | 12 ++++++++++++
 arch/arm/boot/dts/at91-ariettag25.dts | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/at91-ariag25.dts b/arch/arm/boot/dts/at91-ariag25.dts
index 1c86537a42a0..e3e14b7e25aa 100644
--- a/arch/arm/boot/dts/at91-ariag25.dts
+++ b/arch/arm/boot/dts/at91-ariag25.dts
@@ -58,6 +58,18 @@
 				};
 			};
 
+			tcb0: timer at f8008000 {
+				timer at 0 {
+					compatible = "atmel,tcb-timer";
+					reg = <0>;
+				};
+
+				timer at 1 {
+					compatible = "atmel,tcb-timer";
+					reg = <1>;
+				};
+			};
+
 			i2c0: i2c at f8010000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/at91-ariettag25.dts b/arch/arm/boot/dts/at91-ariettag25.dts
index f877f3430bcc..7a34c4dc05d2 100644
--- a/arch/arm/boot/dts/at91-ariettag25.dts
+++ b/arch/arm/boot/dts/at91-ariettag25.dts
@@ -46,6 +46,18 @@
 				};
 			};
 
+			tcb0: timer at f8008000 {
+				timer at 0 {
+					compatible = "atmel,tcb-timer";
+					reg = <0>;
+				};
+
+				timer at 1 {
+					compatible = "atmel,tcb-timer";
+					reg = <1>;
+				};
+			};
+
 			usb2: gadget at f803c000 {
 				status = "okay";
 			};
-- 
2.15.1
