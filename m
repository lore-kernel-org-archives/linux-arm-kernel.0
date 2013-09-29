From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 29 Sep 2013 22:27:57 +0800
Subject: [PATCH 1/3] pinctrl: sirf: add lost uart0-no-stream-control pingroup
 for prima2
Message-ID: <1380464879-19897-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

the old codes defined uart0_nostreamctrl_pins, but missed pingroup
and padmux definition for it. this patch fixes it.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/prima2.dtsi         | 6 ++++++
 drivers/pinctrl/sirf/pinctrl-prima2.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 7cf78af..528ced8 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -388,6 +388,12 @@
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
diff --git a/drivers/pinctrl/sirf/pinctrl-prima2.c b/drivers/pinctrl/sirf/pinctrl-prima2.c
index 1f0ad1e..29fc842 100644
--- a/drivers/pinctrl/sirf/pinctrl-prima2.c
+++ b/drivers/pinctrl/sirf/pinctrl-prima2.c
@@ -764,6 +764,7 @@ static const struct sirfsoc_pin_group sirfsoc_pin_groups[] = {
 	SIRFSOC_PIN_GROUP("lcd_24bitsgrp", lcd_24bits_pins),
 	SIRFSOC_PIN_GROUP("lcdrom_grp", lcdrom_pins),
 	SIRFSOC_PIN_GROUP("uart0grp", uart0_pins),
+	SIRFSOC_PIN_GROUP("uart0_nostreamctrlgrp", uart0_nostreamctrl_pins),
 	SIRFSOC_PIN_GROUP("uart1grp", uart1_pins),
 	SIRFSOC_PIN_GROUP("uart2grp", uart2_pins),
 	SIRFSOC_PIN_GROUP("uart2_nostreamctrlgrp", uart2_nostreamctrl_pins),
@@ -803,6 +804,7 @@ static const char * const lcd_18bitsgrp[] = { "lcd_18bitsgrp" };
 static const char * const lcd_24bitsgrp[] = { "lcd_24bitsgrp" };
 static const char * const lcdromgrp[] = { "lcdromgrp" };
 static const char * const uart0grp[] = { "uart0grp" };
+static const char * const uart0_nostreamctrlgrp[] = { "uart0_nostreamctrlgrp" };
 static const char * const uart1grp[] = { "uart1grp" };
 static const char * const uart2grp[] = { "uart2grp" };
 static const char * const uart2_nostreamctrlgrp[] = { "uart2_nostreamctrlgrp" };
@@ -842,6 +844,7 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 	SIRFSOC_PMX_FUNCTION("lcd_24bits", lcd_24bitsgrp, lcd_24bits_padmux),
 	SIRFSOC_PMX_FUNCTION("lcdrom", lcdromgrp, lcdrom_padmux),
 	SIRFSOC_PMX_FUNCTION("uart0", uart0grp, uart0_padmux),
+	SIRFSOC_PMX_FUNCTION("uart0_nostreamctrl", uart0_nostreamctrlgrp, uart0_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("uart1", uart1grp, uart1_padmux),
 	SIRFSOC_PMX_FUNCTION("uart2", uart2grp, uart2_padmux),
 	SIRFSOC_PMX_FUNCTION("uart2_nostreamctrl", uart2_nostreamctrlgrp, uart2_nostreamctrl_padmux),
-- 
1.8.2.3
