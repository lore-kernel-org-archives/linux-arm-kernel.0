From: florian.vaussard@gmail.com (Florian Vaussard)
Date: Sat, 25 Feb 2017 06:54:24 +0100
Subject: [PATCH 1/6] ARM: dts: socfpga: Add unit name to clock nodes
In-Reply-To: <1488002069-22404-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1488002069-22404-1-git-send-email-florian.vaussard@heig-vd.ch>
Message-ID: <1488002069-22404-2-git-send-email-florian.vaussard@heig-vd.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most clock nodes in Arria5, Cyclone5 and Arria10 have a reg property but
does not have a unit name. This will trigger several warnings like this
one (when compiled with W=1):

Node /soc/clkmgr at ffd04000/clocks/periph_pll has a reg or ranges
property, but no unit name

Add the corresponding unit name to each node.

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 arch/arm/boot/dts/socfpga.dtsi         | 38 ++++++++++++++--------------
 arch/arm/boot/dts/socfpga_arria10.dtsi | 46 +++++++++++++++++-----------------
 2 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 2c43c4d..4dda6d8 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -145,7 +145,7 @@
 						compatible = "fixed-clock";
 					};
 
-					main_pll: main_pll {
+					main_pll: main_pll at 40 {
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#clock-cells = <0>;
@@ -153,7 +153,7 @@
 						clocks = <&osc1>;
 						reg = <0x40>;
 
-						mpuclk: mpuclk {
+						mpuclk: mpuclk at 48 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&main_pll>;
@@ -161,7 +161,7 @@
 							reg = <0x48>;
 						};
 
-						mainclk: mainclk {
+						mainclk: mainclk at 4c {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&main_pll>;
@@ -169,7 +169,7 @@
 							reg = <0x4C>;
 						};
 
-						dbg_base_clk: dbg_base_clk {
+						dbg_base_clk: dbg_base_clk at 50 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&main_pll>, <&osc1>;
@@ -177,21 +177,21 @@
 							reg = <0x50>;
 						};
 
-						main_qspi_clk: main_qspi_clk {
+						main_qspi_clk: main_qspi_clk at 54 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&main_pll>;
 							reg = <0x54>;
 						};
 
-						main_nand_sdmmc_clk: main_nand_sdmmc_clk {
+						main_nand_sdmmc_clk: main_nand_sdmmc_clk at 58 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&main_pll>;
 							reg = <0x58>;
 						};
 
-						cfg_h2f_usr0_clk: cfg_h2f_usr0_clk {
+						cfg_h2f_usr0_clk: cfg_h2f_usr0_clk at 5c {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&main_pll>;
@@ -199,7 +199,7 @@
 						};
 					};
 
-					periph_pll: periph_pll {
+					periph_pll: periph_pll at 80 {
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#clock-cells = <0>;
@@ -207,42 +207,42 @@
 						clocks = <&osc1>, <&osc2>, <&f2s_periph_ref_clk>;
 						reg = <0x80>;
 
-						emac0_clk: emac0_clk {
+						emac0_clk: emac0_clk at 88 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&periph_pll>;
 							reg = <0x88>;
 						};
 
-						emac1_clk: emac1_clk {
+						emac1_clk: emac1_clk at 8c {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&periph_pll>;
 							reg = <0x8C>;
 						};
 
-						per_qspi_clk: per_qsi_clk {
+						per_qspi_clk: per_qsi_clk at 90 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&periph_pll>;
 							reg = <0x90>;
 						};
 
-						per_nand_mmc_clk: per_nand_mmc_clk {
+						per_nand_mmc_clk: per_nand_mmc_clk at 94 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&periph_pll>;
 							reg = <0x94>;
 						};
 
-						per_base_clk: per_base_clk {
+						per_base_clk: per_base_clk at 98 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&periph_pll>;
 							reg = <0x98>;
 						};
 
-						h2f_usr1_clk: h2f_usr1_clk {
+						h2f_usr1_clk: h2f_usr1_clk at 9c {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&periph_pll>;
@@ -250,7 +250,7 @@
 						};
 					};
 
-					sdram_pll: sdram_pll {
+					sdram_pll: sdram_pll at c0 {
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#clock-cells = <0>;
@@ -258,28 +258,28 @@
 						clocks = <&osc1>, <&osc2>, <&f2s_sdram_ref_clk>;
 						reg = <0xC0>;
 
-						ddr_dqs_clk: ddr_dqs_clk {
+						ddr_dqs_clk: ddr_dqs_clk at c8 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&sdram_pll>;
 							reg = <0xC8>;
 						};
 
-						ddr_2x_dqs_clk: ddr_2x_dqs_clk {
+						ddr_2x_dqs_clk: ddr_2x_dqs_clk at cc {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&sdram_pll>;
 							reg = <0xCC>;
 						};
 
-						ddr_dq_clk: ddr_dq_clk {
+						ddr_dq_clk: ddr_dq_clk at d0 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&sdram_pll>;
 							reg = <0xD0>;
 						};
 
-						h2f_usr2_clk: h2f_usr2_clk {
+						h2f_usr2_clk: h2f_usr2_clk at d4 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&sdram_pll>;
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 6b0b746..0332d51 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -119,7 +119,7 @@
 						compatible = "fixed-clock";
 					};
 
-					main_pll: main_pll {
+					main_pll: main_pll at 40 {
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#clock-cells = <0>;
@@ -142,35 +142,35 @@
 							div-reg = <0x144 0 11>;
 						};
 
-						main_emaca_clk: main_emaca_clk {
+						main_emaca_clk: main_emaca_clk at 68 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&main_pll>;
 							reg = <0x68>;
 						};
 
-						main_emacb_clk: main_emacb_clk {
+						main_emacb_clk: main_emacb_clk at 6c {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&main_pll>;
 							reg = <0x6C>;
 						};
 
-						main_emac_ptp_clk: main_emac_ptp_clk {
+						main_emac_ptp_clk: main_emac_ptp_clk at 70 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&main_pll>;
 							reg = <0x70>;
 						};
 
-						main_gpio_db_clk: main_gpio_db_clk {
+						main_gpio_db_clk: main_gpio_db_clk at 74 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&main_pll>;
 							reg = <0x74>;
 						};
 
-						main_sdmmc_clk: main_sdmmc_clk {
+						main_sdmmc_clk: main_sdmmc_clk at 78 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk"
 ;
@@ -178,28 +178,28 @@
 							reg = <0x78>;
 						};
 
-						main_s2f_usr0_clk: main_s2f_usr0_clk {
+						main_s2f_usr0_clk: main_s2f_usr0_clk at 7c {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&main_pll>;
 							reg = <0x7C>;
 						};
 
-						main_s2f_usr1_clk: main_s2f_usr1_clk {
+						main_s2f_usr1_clk: main_s2f_usr1_clk at 80 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&main_pll>;
 							reg = <0x80>;
 						};
 
-						main_hmc_pll_ref_clk: main_hmc_pll_ref_clk {
+						main_hmc_pll_ref_clk: main_hmc_pll_ref_clk at 84 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&main_pll>;
 							reg = <0x84>;
 						};
 
-						main_periph_ref_clk: main_periph_ref_clk {
+						main_periph_ref_clk: main_periph_ref_clk at 9c {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&main_pll>;
@@ -207,7 +207,7 @@
 						};
 					};
 
-					periph_pll: periph_pll {
+					periph_pll: periph_pll at c0 {
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#clock-cells = <0>;
@@ -230,56 +230,56 @@
 							div-reg = <0x144 16 11>;
 						};
 
-						peri_emaca_clk: peri_emaca_clk {
+						peri_emaca_clk: peri_emaca_clk at e8 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&periph_pll>;
 							reg = <0xE8>;
 						};
 
-						peri_emacb_clk: peri_emacb_clk {
+						peri_emacb_clk: peri_emacb_clk at ec {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&periph_pll>;
 							reg = <0xEC>;
 						};
 
-						peri_emac_ptp_clk: peri_emac_ptp_clk {
+						peri_emac_ptp_clk: peri_emac_ptp_clk at f0 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&periph_pll>;
 							reg = <0xF0>;
 						};
 
-						peri_gpio_db_clk: peri_gpio_db_clk {
+						peri_gpio_db_clk: peri_gpio_db_clk at f4 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&periph_pll>;
 							reg = <0xF4>;
 						};
 
-						peri_sdmmc_clk: peri_sdmmc_clk {
+						peri_sdmmc_clk: peri_sdmmc_clk at f8 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&periph_pll>;
 							reg = <0xF8>;
 						};
 
-						peri_s2f_usr0_clk: peri_s2f_usr0_clk {
+						peri_s2f_usr0_clk: peri_s2f_usr0_clk at fc {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&periph_pll>;
 							reg = <0xFC>;
 						};
 
-						peri_s2f_usr1_clk: peri_s2f_usr1_clk {
+						peri_s2f_usr1_clk: peri_s2f_usr1_clk at 100 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&periph_pll>;
 							reg = <0x100>;
 						};
 
-						peri_hmc_pll_ref_clk: peri_hmc_pll_ref_clk {
+						peri_hmc_pll_ref_clk: peri_hmc_pll_ref_clk at 104 {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&periph_pll>;
@@ -287,7 +287,7 @@
 						};
 					};
 
-					mpu_free_clk: mpu_free_clk {
+					mpu_free_clk: mpu_free_clk at 60 {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-a10-perip-clk";
 						clocks = <&main_mpu_base_clk>, <&peri_mpu_base_clk>,
@@ -296,7 +296,7 @@
 						reg = <0x60>;
 					};
 
-					noc_free_clk: noc_free_clk {
+					noc_free_clk: noc_free_clk at 64 {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-a10-perip-clk";
 						clocks = <&main_noc_base_clk>, <&peri_noc_base_clk>,
@@ -305,7 +305,7 @@
 						reg = <0x64>;
 					};
 
-					s2f_user1_free_clk: s2f_user1_free_clk {
+					s2f_user1_free_clk: s2f_user1_free_clk at 104 {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-a10-perip-clk";
 						clocks = <&main_s2f_usr1_clk>, <&peri_s2f_usr1_clk>,
@@ -314,7 +314,7 @@
 						reg = <0x104>;
 					};
 
-					sdmmc_free_clk: sdmmc_free_clk {
+					sdmmc_free_clk: sdmmc_free_clk at f8 {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-a10-perip-clk";
 						clocks = <&main_sdmmc_clk>, <&peri_sdmmc_clk>,
-- 
2.7.4
