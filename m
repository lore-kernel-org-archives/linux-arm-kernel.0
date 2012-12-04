From: manabian@gmail.com (Joachim Eastwood)
Date: Tue,  4 Dec 2012 19:10:57 +0100
Subject: [PATCH 2/4] ARM: at91: add MMC bindings to RM9200 DT
In-Reply-To: <1354644659-31385-1-git-send-email-manabian@gmail.com>
References: <1354644659-31385-1-git-send-email-manabian@gmail.com>
Message-ID: <1354644659-31385-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi | 42 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/at91rm9200.c   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 222047f..73edf021 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -88,6 +88,15 @@
 				interrupts = <20 4 0 21 4 0 22 4 0>;
 			};
 
+			mmc0: mmc at fffb4000 {
+				compatible = "atmel,hsmci";
+				reg = <0xfffb4000 0x4000>;
+				interrupts = <10 4 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			pinctrl at fffff400 {
 				#address-cells = <1>;
 				#size-cells = <1>;
@@ -207,6 +216,39 @@
 					};
 				};
 
+				mmc0 {
+					pinctrl_mmc0_clk: mmc0_clk-0 {
+						atmel,pins =
+							<0 27 0x1 0x0>;	/* PA27 periph A */
+					};
+
+					pinctrl_mmc0_slot0_cmd_dat0: mmc0_slot0_cmd_dat0-0 {
+						atmel,pins =
+							<0 28 0x1 0x1	/* PA28 periph A with pullup */
+							 0 29 0x1 0x1>;	/* PA29 periph A with pullup */
+					};
+
+					pinctrl_mmc0_slot0_dat1_3: mmc0_slot0_dat1_3-0 {
+						atmel,pins =
+							<1 3 0x2 0x1	/* PB3 periph B with pullup */
+							 1 4 0x2 0x1	/* PB4 periph B with pullup */
+							 1 5 0x2 0x1>;	/* PB5 periph B with pullup */
+					};
+
+					pinctrl_mmc0_slot1_cmd_dat0: mmc0_slot1_cmd_dat0-0 {
+						atmel,pins =
+							<0 8 0x2 0x1	/* PA8 periph B with pullup */
+							 0 9 0x2 0x1>;	/* PA9 periph B with pullup */
+					};
+
+					pinctrl_mmc0_slot1_dat1_3: mmc0_slot1_dat1_3-0 {
+						atmel,pins =
+							<0 10 0x2 0x1	/* PA10 periph B with pullup */
+							 0 11 0x2 0x1	/* PA11 periph B with pullup */
+							 0 12 0x2 0x1>;	/* PA12 periph B with pullup */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 6cceb42..ffb339b 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -207,6 +207,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "fffa4000.timer", &tc3_clk),
 	CLKDEV_CON_DEV_ID("t1_clk", "fffa4000.timer", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "fffa4000.timer", &tc5_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "fffb4000.mmc", &mmc_clk),
 	CLKDEV_CON_DEV_ID("hclk", "300000.ohci", &ohci_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fffff400.gpio", &pioA_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fffff600.gpio", &pioB_clk),
-- 
1.8.0
