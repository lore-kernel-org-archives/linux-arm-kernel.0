From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 19 Aug 2013 16:15:49 +0800
Subject: [PATCH] pinctrl: sirf: add lost atlas6 uart0-no-stream-control
 pingroup
Message-ID: <1376900149-27298-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

the old codes defined uart0_nostreamctrl_pins, but missed pingroup
and padmux definition for it. this patch fixes it.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi         | 6 ++++++
 drivers/pinctrl/sirf/pinctrl-atlas6.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index a0f2721..8678e0c 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -329,6 +329,12 @@
 						sirf,function = "uart0";
 					};
 				};
+				uart0_noflow_pins_a: uart0 at 1 {
+					uart {
+						sirf,pins = "uart0_nostreamctrlgrp";
+						sirf,function = "uart0_nostreamctrl";
+					};
+				};
 				uart1_pins_a: uart1 at 0 {
 					uart {
 						sirf,pins = "uart1grp";
diff --git a/drivers/pinctrl/sirf/pinctrl-atlas6.c b/drivers/pinctrl/sirf/pinctrl-atlas6.c
index 867c968..edf45a6 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas6.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas6.c
@@ -831,6 +831,7 @@ static const struct sirfsoc_pin_group sirfsoc_pin_groups[] = {
 	SIRFSOC_PIN_GROUP("lcd_24bitsgrp", lcd_24bits_pins),
 	SIRFSOC_PIN_GROUP("lcdrom_grp", lcdrom_pins),
 	SIRFSOC_PIN_GROUP("uart0grp", uart0_pins),
+	SIRFSOC_PIN_GROUP("uart0_nostreamctrlgrp", uart0_nostreamctrl_pins),
 	SIRFSOC_PIN_GROUP("uart1grp", uart1_pins),
 	SIRFSOC_PIN_GROUP("uart2grp", uart2_pins),
 	SIRFSOC_PIN_GROUP("uart2_nostreamctrlgrp", uart2_nostreamctrl_pins),
@@ -874,6 +875,7 @@ static const char * const lcd_18bitsgrp[] = { "lcd_18bitsgrp" };
 static const char * const lcd_24bitsgrp[] = { "lcd_24bitsgrp" };
 static const char * const lcdromgrp[] = { "lcdromgrp" };
 static const char * const uart0grp[] = { "uart0grp" };
+static const char * const uart0_nostreamctrlgrp[] = { "uart0_nostreamctrlgrp" };
 static const char * const uart1grp[] = { "uart1grp" };
 static const char * const uart2grp[] = { "uart2grp" };
 static const char * const uart2_nostreamctrlgrp[] = { "uart2_nostreamctrlgrp" };
@@ -917,6 +919,8 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 	SIRFSOC_PMX_FUNCTION("lcd_24bits", lcd_24bitsgrp, lcd_24bits_padmux),
 	SIRFSOC_PMX_FUNCTION("lcdrom", lcdromgrp, lcdrom_padmux),
 	SIRFSOC_PMX_FUNCTION("uart0", uart0grp, uart0_padmux),
+	SIRFSOC_PMX_FUNCTION("uart0_nostreamctrl", uart0_nostreamctrlgrp,
+						uart0_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("uart1", uart1grp, uart1_padmux),
 	SIRFSOC_PMX_FUNCTION("uart2", uart2grp, uart2_padmux),
 	SIRFSOC_PMX_FUNCTION("uart2_nostreamctrl", uart2_nostreamctrlgrp, uart2_nostreamctrl_padmux),
-- 
1.8.2.3
