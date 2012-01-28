From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 28 Jan 2012 06:10:41 +0100
Subject: [FOR 3.3 PATCH 3/6] ARM: at91: enable on flash bbt for Atmel
 Reference and DT boards
In-Reply-To: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
References: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1327727444-23908-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable it on Calao board too

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-cap9adk.c      |    1 +
 arch/arm/mach-at91/board-dt.c           |    1 +
 arch/arm/mach-at91/board-qil-a9260.c    |    1 +
 arch/arm/mach-at91/board-rm9200dk.c     |    1 +
 arch/arm/mach-at91/board-sam9260ek.c    |    1 +
 arch/arm/mach-at91/board-sam9261ek.c    |    1 +
 arch/arm/mach-at91/board-sam9263ek.c    |    1 +
 arch/arm/mach-at91/board-sam9g20ek.c    |    1 +
 arch/arm/mach-at91/board-sam9m10g45ek.c |    1 +
 arch/arm/mach-at91/board-sam9rlek.c     |    1 +
 arch/arm/mach-at91/board-usb-a926x.c    |    1 +
 11 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index 9c05eea..3618dcf91 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -179,6 +179,7 @@ static struct atmel_nand_data __initdata cap9adk_nand_data = {
 	.rdy_pin	= -EINVAL,
 	.enable_pin	= AT91_PIN_PD15,
 	.ecc_mode	= NAND_ECC_SOFT,
+	.on_flash_bbt	= 1,
 	.parts		= cap9adk_nand_partitions,
 	.num_parts	= ARRAY_SIZE(cap9adk_nand_partitions),
 };
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index 552390d..a42cad8 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -54,6 +54,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC8,
 	.enable_pin	= AT91_PIN_PC14,
 	.ecc_mode	= NAND_ECC_SOFT,
+	.on_flash_bbt	= 1,
 };
 
 static struct sam9_smc_config __initdata ek_nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index 97907e4..b6ed5ed 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -139,6 +139,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
 	.ecc_mode	= NAND_ECC_SOFT,
+	.on_flash_bbt	= 1,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 55a5202..d49d004 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -150,6 +150,7 @@ static struct atmel_nand_data __initdata dk_nand_data = {
 	.rdy_pin	= AT91_PIN_PC2,
 	.enable_pin	= -EINVAL,
 	.ecc_mode	= NAND_ECC_SOFT,
+	.on_flash_bbt	= 1,
 	.parts		= dk_nand_partition,
 	.num_parts	= ARRAY_SIZE(dk_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index 3118ab1..d5aec55 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -182,6 +182,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
 	.ecc_mode	= NAND_ECC_SOFT,
+	.on_flash_bbt	= 1,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 60cf37b..c3f9944 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -188,6 +188,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC15,
 	.enable_pin	= AT91_PIN_PC14,
 	.ecc_mode	= NAND_ECC_SOFT,
+	.on_flash_bbt	= 1,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index aeabf85..66f0ddf 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -188,6 +188,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PA22,
 	.enable_pin	= AT91_PIN_PD15,
 	.ecc_mode	= NAND_ECC_SOFT,
+	.on_flash_bbt	= 1,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 419e0d5..8923ec9 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -167,6 +167,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.enable_pin	= AT91_PIN_PC14,
 	.det_pin	= -EINVAL,
 	.ecc_mode	= NAND_ECC_SOFT,
+	.on_flash_bbt	= 1,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 452ec37..31eb24a 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -147,6 +147,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.enable_pin	= AT91_PIN_PC14,
 	.det_pin	= -EINVAL,
 	.ecc_mode	= NAND_ECC_SOFT,
+	.on_flash_bbt	= 1,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 70a026d..b109ce2 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -95,6 +95,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PD17,
 	.enable_pin	= AT91_PIN_PB6,
 	.ecc_mode	= NAND_ECC_SOFT,
+	.on_flash_bbt	= 1,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index cc93152..b7483a3 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -199,6 +199,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PA22,
 	.enable_pin	= AT91_PIN_PD15,
 	.ecc_mode	= NAND_ECC_SOFT,
+	.on_flash_bbt	= 1,
 	.parts		= ek_nand_partition,
 	.num_parts	= ARRAY_SIZE(ek_nand_partition),
 };
-- 
1.7.7
