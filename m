From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 13 Apr 2011 18:29:01 +0200
Subject: [PATCH] at91: remove MTD_NAND_ATMEL_BUSWIDTH_16 option
Message-ID: <1302712141-6952-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

no board configure it as 'n' and it's an issue to merge all defconfigs
in one

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/Kconfig                |   19 -------------------
 arch/arm/mach-at91/board-at572d940hf_ek.c |    4 ----
 arch/arm/mach-at91/board-cap9adk.c        |    4 ----
 arch/arm/mach-at91/board-sam9260ek.c      |    4 ----
 arch/arm/mach-at91/board-sam9261ek.c      |    4 ----
 arch/arm/mach-at91/board-sam9263ek.c      |    4 ----
 arch/arm/mach-at91/board-sam9g20ek.c      |    4 ----
 arch/arm/mach-at91/board-sam9m10g45ek.c   |    4 ----
 8 files changed, 0 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 1939023..da5d708 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -3,9 +3,6 @@ if ARCH_AT91
 config HAVE_AT91_DATAFLASH_CARD
 	bool
 
-config HAVE_NAND_ATMEL_BUSWIDTH_16
-	bool
-
 config HAVE_AT91_USART3
 	bool
 
@@ -208,7 +205,6 @@ comment "AT91SAM9260 / AT91SAM9XE Board Type"
 config MACH_AT91SAM9260EK
 	bool "Atmel AT91SAM9260-EK / AT91SAM9XE Evaluation Kit"
 	select HAVE_AT91_DATAFLASH_CARD
-	select HAVE_NAND_ATMEL_BUSWIDTH_16
 	help
 	  Select this if you are using Atmel's AT91SAM9260-EK or AT91SAM9XE Evaluation Kit
 	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=3933>
@@ -269,7 +265,6 @@ comment "AT91SAM9261 Board Type"
 config MACH_AT91SAM9261EK
 	bool "Atmel AT91SAM9261-EK Evaluation Kit"
 	select HAVE_AT91_DATAFLASH_CARD
-	select HAVE_NAND_ATMEL_BUSWIDTH_16
 	help
 	  Select this if you are using Atmel's AT91SAM9261-EK Evaluation Kit.
 	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=3820>
@@ -285,7 +280,6 @@ comment "AT91SAM9G10 Board Type"
 config MACH_AT91SAM9G10EK
 	bool "Atmel AT91SAM9G10-EK Evaluation Kit"
 	select HAVE_AT91_DATAFLASH_CARD
-	select HAVE_NAND_ATMEL_BUSWIDTH_16
 	help
 	  Select this if you are using Atmel's AT91SAM9G10-EK Evaluation Kit.
 	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=4588>
@@ -301,7 +295,6 @@ comment "AT91SAM9263 Board Type"
 config MACH_AT91SAM9263EK
 	bool "Atmel AT91SAM9263-EK Evaluation Kit"
 	select HAVE_AT91_DATAFLASH_CARD
-	select HAVE_NAND_ATMEL_BUSWIDTH_16
 	help
 	  Select this if you are using Atmel's AT91SAM9263-EK Evaluation Kit.
 	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=4057>
@@ -342,7 +335,6 @@ comment "AT91SAM9G20 Board Type"
 config MACH_AT91SAM9G20EK
 	bool "Atmel AT91SAM9G20-EK Evaluation Kit"
 	select HAVE_AT91_DATAFLASH_CARD
-	select HAVE_NAND_ATMEL_BUSWIDTH_16
 	help
 	  Select this if you are using Atmel's AT91SAM9G20-EK Evaluation Kit
 	  that embeds only one SD/MMC slot.
@@ -350,7 +342,6 @@ config MACH_AT91SAM9G20EK
 config MACH_AT91SAM9G20EK_2MMC
 	depends on MACH_AT91SAM9G20EK
 	bool "Atmel AT91SAM9G20-EK Evaluation Kit with 2 SD/MMC Slots"
-	select HAVE_NAND_ATMEL_BUSWIDTH_16
 	help
 	  Select this if you are using an Atmel AT91SAM9G20-EK Evaluation Kit
 	  with 2 SD/MMC Slots. This is the case for AT91SAM9G20-EK rev. C and
@@ -415,7 +406,6 @@ comment "AT91SAM9G45 Board Type"
 
 config MACH_AT91SAM9M10G45EK
 	bool "Atmel AT91SAM9M10G45-EK Evaluation Kits"
-	select HAVE_NAND_ATMEL_BUSWIDTH_16
 	help
 	  Select this if you are using Atmel's AT91SAM9G45-EKES Evaluation Kit.
 	  "ES" at the end of the name means that this board is an
@@ -432,7 +422,6 @@ comment "AT91CAP9 Board Type"
 config MACH_AT91CAP9ADK
 	bool "Atmel AT91CAP9A-DK Evaluation Kit"
 	select HAVE_AT91_DATAFLASH_CARD
-	select HAVE_NAND_ATMEL_BUSWIDTH_16
 	help
 	  Select this if you are using Atmel's AT91CAP9A-DK Evaluation Kit.
 	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=4138>
@@ -449,7 +438,6 @@ config MACH_AT572D940HFEB
 	bool "AT572D940HF-EK"
 	depends on ARCH_AT572D940HF
 	select HAVE_AT91_DATAFLASH_CARD
-	select HAVE_NAND_ATMEL_BUSWIDTH_16
 	help
 	  Select this if you are using Atmel's AT572D940HF-EK evaluation kit.
 	  <http://www.atmel.com/products/diopsis/default.asp>
@@ -482,13 +470,6 @@ config MTD_AT91_DATAFLASH_CARD
 	help
 	  Enable support for the DataFlash card.
 
-config MTD_NAND_ATMEL_BUSWIDTH_16
-	bool "Enable 16-bit data bus interface to NAND flash"
-	depends on HAVE_NAND_ATMEL_BUSWIDTH_16
-	help
-	  On AT91SAM926x boards both types of NAND flash can be present
-	  (8 and 16 bit data bus width).
-
 # ----------------------------------------------------------
 
 comment "AT91 Feature Selections"
diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index 3929f1c..1cd80d6 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -216,11 +216,7 @@ static struct atmel_nand_data __initdata eb_nand_data = {
 /*	.rdy_pin	= AT91_PIN_PC16, */
 	.enable_pin	= AT91_PIN_PA15,
 	.partition_info	= nand_partitions,
-#if defined(CONFIG_MTD_NAND_ATMEL_BUSWIDTH_16)
 	.bus_width_16	= 1,
-#else
-	.bus_width_16	= 0,
-#endif
 };
 
 static struct sam9_smc_config __initdata eb_nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index e727444..4014a14 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -187,11 +187,7 @@ static struct atmel_nand_data __initdata cap9adk_nand_data = {
 //	.rdy_pin	= ... not connected
 	.enable_pin	= AT91_PIN_PD15,
 	.partition_info	= nand_partitions,
-#if defined(CONFIG_MTD_NAND_ATMEL_BUSWIDTH_16)
 	.bus_width_16	= 1,
-#else
-	.bus_width_16	= 0,
-#endif
 };
 
 static struct sam9_smc_config __initdata cap9adk_nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index de1816e..f1c9aa2 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -191,11 +191,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
 	.partition_info	= nand_partitions,
-#if defined(CONFIG_MTD_NAND_ATMEL_BUSWIDTH_16)
 	.bus_width_16	= 1,
-#else
-	.bus_width_16	= 0,
-#endif
 };
 
 static struct sam9_smc_config __initdata ek_nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 14acc90..2afbada 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -197,11 +197,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC15,
 	.enable_pin	= AT91_PIN_PC14,
 	.partition_info	= nand_partitions,
-#if defined(CONFIG_MTD_NAND_ATMEL_BUSWIDTH_16)
 	.bus_width_16	= 1,
-#else
-	.bus_width_16	= 0,
-#endif
 };
 
 static struct sam9_smc_config __initdata ek_nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index bfe490d..61518b5 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -198,11 +198,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PA22,
 	.enable_pin	= AT91_PIN_PD15,
 	.partition_info	= nand_partitions,
-#if defined(CONFIG_MTD_NAND_ATMEL_BUSWIDTH_16)
 	.bus_width_16	= 1,
-#else
-	.bus_width_16	= 0,
-#endif
 };
 
 static struct sam9_smc_config __initdata ek_nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index ca8198b..fb0c9b5 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -175,11 +175,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
 	.partition_info	= nand_partitions,
-#if defined(CONFIG_MTD_NAND_ATMEL_BUSWIDTH_16)
 	.bus_width_16	= 1,
-#else
-	.bus_width_16	= 0,
-#endif
 };
 
 static struct sam9_smc_config __initdata ek_nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 6c999db..d202bc0 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -155,11 +155,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC8,
 	.enable_pin	= AT91_PIN_PC14,
 	.partition_info	= nand_partitions,
-#if defined(CONFIG_MTD_NAND_ATMEL_BUSWIDTH_16)
 	.bus_width_16	= 1,
-#else
-	.bus_width_16	= 0,
-#endif
 };
 
 static struct sam9_smc_config __initdata ek_nand_smc_config = {
-- 
1.7.4.1
