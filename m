From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:50:54 +0200
Subject: [PATCH 13/58] ARM: dts: at91: ge863-pro3: use TCB0 as clocksource
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-14-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 as the clocksource like previously selected in at91_dt_defconfig.

Cc: Fabio Porcedda <fabio.porcedda@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/ge863-pro3.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/ge863-pro3.dtsi b/arch/arm/boot/dts/ge863-pro3.dtsi
index 4aee5cc75fa4..eef2303806bc 100644
--- a/arch/arm/boot/dts/ge863-pro3.dtsi
+++ b/arch/arm/boot/dts/ge863-pro3.dtsi
@@ -18,6 +18,18 @@
 
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
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
-- 
2.11.0
