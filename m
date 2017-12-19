From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:53 +0100
Subject: [PATCH 29/45] ARM: dts: at91: cosino: use TCB0 as timers
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-30-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 for timers as selected in at91_dt_defconfig.

Cc: Rodolfo Giometti <giometti@linux.it>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-cosino.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-cosino.dtsi b/arch/arm/boot/dts/at91-cosino.dtsi
index 89cde175154e..295a5a43fe01 100644
--- a/arch/arm/boot/dts/at91-cosino.dtsi
+++ b/arch/arm/boot/dts/at91-cosino.dtsi
@@ -37,6 +37,18 @@
 
 	ahb {
 		apb {
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
 			mmc0: mmc at f0008000 {
 				pinctrl-0 = <
 					&pinctrl_board_mmc0
-- 
2.15.1
