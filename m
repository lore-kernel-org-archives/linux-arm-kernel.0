From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Nov 2012 15:56:39 +0100
Subject: [PATCH 1/4] ARM: at91: dt: at91sam9: add mmc pinctrl support
In-Reply-To: <20121121145552.GW4398@game.jcrosoft.org>
References: <20121121145552.GW4398@game.jcrosoft.org>
Message-ID: <1353509802-20445-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |   33 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi |   66 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |   48 ++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi |   24 +++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |   32 +++++++++++++++++
 5 files changed, 203 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index d7296d5..b1d3fab 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -272,6 +272,39 @@
 					};
 				};
 
+				mmc0 {
+					pinctrl_mmc0_clk: mmc0_clk-0 {
+						atmel,pins =
+							<0 8 0x1 0x0>;	/* PA8 periph A */
+					};
+
+					pinctrl_mmc0_slot0_cmd_dat0: mmc0_slot0_cmd_dat0-0 {
+						atmel,pins =
+							<0 7 0x1 0x1	/* PA7 periph A with pullup */
+							 0 6 0x1 0x1>;	/* PA6 periph A with pullup */
+					};
+
+					pinctrl_mmc0_slot0_dat1_3: mmc0_slot0_dat1_3-0 {
+						atmel,pins =
+							<0 9 0x1 0x1	/* PA9 periph A with pullup */
+							 0 10 0x1 0x1	/* PA10 periph A with pullup */
+							 0 11 0x1 0x1>;	/* PA11 periph A with pullup */
+					};
+
+					pinctrl_mmc0_slot1_cmd_dat0: mmc0_slot1_cmd_dat0-0 {
+						atmel,pins =
+							<0 1 0x2 0x1	/* PA1 periph B with pullup */
+							 0 0 0x2 0x1>;	/* PA0 periph B with pullup */
+					};
+
+					pinctrl_mmc0_slot1_dat1_3: mmc0_slot1_dat1_3-0 {
+						atmel,pins =
+							<0 5 0x2 0x1	/* PA5 periph B with pullup */
+							 0 4 0x2 0x1	/* PA4 periph B with pullup */
+							 0 3 0x2 0x1>;	/* PA3 periph B with pullup */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index eae6d16..66106ee 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -203,6 +203,72 @@
 					};
 				};
 
+				mmc0 {
+					pinctrl_mmc0_clk: mmc0_clk-0 {
+						atmel,pins =
+							<0 12 0x1 0x0>;	/* PA12 periph A */
+					};
+
+					pinctrl_mmc0_slot0_cmd_dat0: mmc0_slot0_cmd_dat0-0 {
+						atmel,pins =
+							<0 1 0x1 0x1	/* PA1 periph A with pullup */
+							 0 0 0x1 0x1>;	/* PA0 periph A with pullup */
+					};
+
+					pinctrl_mmc0_slot0_dat1_3: mmc0_slot0_dat1_3-0 {
+						atmel,pins =
+							<0 3 0x1 0x1	/* PA3 periph A with pullup */
+							 0 4 0x1 0x1	/* PA4 periph A with pullup */
+							 0 5 0x1 0x1>;	/* PA5 periph A with pullup */
+					};
+
+					pinctrl_mmc0_slot1_cmd_dat0: mmc0_slot1_cmd_dat0-0 {
+						atmel,pins =
+							<0 16 0x1 0x1	/* PA16 periph A with pullup */
+							 0 17 0x1 0x1>;	/* PA17 periph A with pullup */
+					};
+
+					pinctrl_mmc0_slot1_dat1_3: mmc0_slot1_dat1_3-0 {
+						atmel,pins =
+							<0 18 0x1 0x1	/* PA18 periph A with pullup */
+							 0 19 0x1 0x1	/* PA19 periph A with pullup */
+							 0 20 0x1 0x1>;	/* PA20 periph A with pullup */
+					};
+				};
+
+				mmc1 {
+					pinctrl_mmc1_clk: mmc1_clk-0 {
+						atmel,pins =
+							<0 6 0x1 0x0>;	/* PA6 periph A */
+					};
+
+					pinctrl_mmc1_slot0_cmd_dat0: mmc1_slot0_cmd_dat0-0 {
+						atmel,pins =
+							<0 7 0x1 0x1	/* PA7 periph A with pullup */
+							 0 8 0x1 0x1>;	/* PA8 periph A with pullup */
+					};
+
+					pinctrl_mmc1_slot0_dat1_3: mmc1_slot0_dat1_3-0 {
+						atmel,pins =
+							<0 9 0x1 0x1	/* PA9 periph A with pullup */
+							 0 10 0x1 0x1	/* PA10 periph A with pullup */
+							 0 11 0x1 0x1>;	/* PA11 periph A with pullup */
+					};
+
+					pinctrl_mmc1_slot1_cmd_dat0: mmc1_slot1_cmd_dat0-0 {
+						atmel,pins =
+							<0 21 0x1 0x1	/* PA21 periph A with pullup */
+							 0 22 0x1 0x1>;	/* PA22 periph A with pullup */
+					};
+
+					pinctrl_mmc1_slot1_dat1_3: mmc1_slot1_dat1_3-0 {
+						atmel,pins =
+							<0 23 0x1 0x1	/* PA23 periph A with pullup */
+							 0 24 0x1 0x1	/* PA24 periph A with pullup */
+							 0 25 0x1 0x1>;	/* PA25 periph A with pullup */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 91607d2..0741cae 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -240,6 +240,54 @@
 					};
 				};
 
+				mmc0 {
+					pinctrl_mmc0_slot0_clk_cmd_dat0: mmc0_slot0_clk_cmd_dat0-0 {
+						atmel,pins =
+							<0 0 0x1 0x0	/* PA0 periph A */
+							 0 1 0x1 0x1	/* PA1 periph A with pullup */
+							 0 2 0x1 0x1>;	/* PA2 periph A with pullup */
+					};
+
+					pinctrl_mmc0_slot0_dat1_3: mmc0_slot0_dat1_3-0 {
+						atmel,pins =
+							<0 3 0x1 0x1	/* PA3 periph A with pullup */
+							 0 4 0x1 0x1	/* PA4 periph A with pullup */
+							 0 5 0x1 0x1>;	/* PA5 periph A with pullup */
+					};
+
+					pinctrl_mmc0_slot0_dat4_7: mmc0_slot0_dat4_7-0 {
+						atmel,pins =
+							<0 6 0x1 0x1	/* PA6 periph A with pullup */
+							 0 7 0x1 0x1	/* PA7 periph A with pullup */
+							 0 8 0x1 0x1	/* PA8 periph A with pullup */
+							 0 9 0x1 0x1>;	/* PA9 periph A with pullup */
+					};
+				};
+
+				mmc1 {
+					pinctrl_mmc1_slot0_clk_cmd_dat0: mmc1_slot0_clk_cmd_dat0-0 {
+						atmel,pins =
+							<0 31 0x1 0x0	/* PA31 periph A */
+							 0 22 0x1 0x1	/* PA22 periph A with pullup */
+							 0 23 0x1 0x1>;	/* PA23 periph A with pullup */
+					};
+
+					pinctrl_mmc1_slot0_dat1_3: mmc1_slot0_dat1_3-0 {
+						atmel,pins =
+							<0 24 0x1 0x1	/* PA24 periph A with pullup */
+							 0 25 0x1 0x1	/* PA25 periph A with pullup */
+							 0 26 0x1 0x1>;	/* PA26 periph A with pullup */
+					};
+
+					pinctrl_mmc1_slot0_dat4_7: mmc1_slot0_dat4_7-0 {
+						atmel,pins =
+							<0 27 0x1 0x1	/* PA27 periph A with pullup */
+							 0 28 0x1 0x1	/* PA28 periph A with pullup */
+							 0 29 0x1 0x1	/* PA29 periph A with pullup */
+							 0 20 0x1 0x1>;	/* PA30 periph A with pullup */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 8d1fdfa..e9efb34 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -220,6 +220,30 @@
 					};
 				};
 
+				mmc0 {
+					pinctrl_mmc0_slot0_clk_cmd_dat0: mmc0_slot0_clk_cmd_dat0-0 {
+						atmel,pins =
+							<0 17 0x1 0x0	/* PA17 periph A */
+							 0 16 0x1 0x1	/* PA16 periph A with pullup */
+							 0 15 0x1 0x1>;	/* PA15 periph A with pullup */
+					};
+
+					pinctrl_mmc0_slot0_dat1_3: mmc0_slot0_dat1_3-0 {
+						atmel,pins =
+							<0 18 0x1 0x1	/* PA18 periph A with pullup */
+							 0 19 0x1 0x1	/* PA19 periph A with pullup */
+							 0 20 0x1 0x1>;	/* PA20 periph A with pullup */
+					};
+
+					pinctrl_mmc0_slot0_dat4_7: mmc0_slot0_dat4_7-0 {
+						atmel,pins =
+							<0 11 0x2 0x1	/* PA11 periph B with pullup */
+							 0 12 0x2 0x1	/* PA12 periph B with pullup */
+							 0 13 0x2 0x1	/* PA13 periph B with pullup */
+							 0 14 0x2 0x1>;	/* PA14 periph B with pullup */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 7f56b07..7ee49e8 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -250,6 +250,38 @@
 					};
 				};
 
+				mmc0 {
+					pinctrl_mmc0_slot0_clk_cmd_dat0: mmc0_slot0_clk_cmd_dat0-0 {
+						atmel,pins =
+							<0 17 0x1 0x0	/* PA17 periph A */
+							 0 16 0x1 0x1	/* PA16 periph A with pullup */
+							 0 15 0x1 0x1>;	/* PA15 periph A with pullup */
+					};
+
+					pinctrl_mmc0_slot0_dat1_3: mmc0_slot0_dat1_3-0 {
+						atmel,pins =
+							<0 18 0x1 0x1	/* PA18 periph A with pullup */
+							 0 19 0x1 0x1	/* PA19 periph A with pullup */
+							 0 20 0x1 0x1>;	/* PA20 periph A with pullup */
+					};
+				};
+
+				mmc1 {
+					pinctrl_mmc1_slot0_clk_cmd_dat0: mmc1_slot0_clk_cmd_dat0-0 {
+						atmel,pins =
+							<0 13 0x2 0x0	/* PA13 periph B */
+							 0 12 0x2 0x1	/* PA12 periph B with pullup */
+							 0 11 0x2 0x1>;	/* PA11 periph B with pullup */
+					};
+
+					pinctrl_mmc1_slot0_dat1_3: mmc1_slot0_dat1_3-0 {
+						atmel,pins =
+							<0 2 0x2 0x1	/* PA2 periph B with pullup */
+							 0 3 0x2 0x1	/* PA3 periph B with pullup */
+							 0 4 0x2 0x1>;	/* PA4 periph B with pullup */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
-- 
1.7.10.4
