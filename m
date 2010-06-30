From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 17:53:52 +0200
Subject: [PATCH 01/33] Removing dead MTD_NAND_AT91_BUSWIDTH_16
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <4c6fe9a4c298214223ff89d06401ac7b66f81c98.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MTD_NAND_AT91_BUSWIDTH_16 doesn't exist in Kconfig, therefore removing
all references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-at91/board-at572d940hf_ek.c |    4 ----
 arch/arm/mach-at91/board-sam9m10g45ek.c   |    4 ----
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index 5daff27..889a442 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -216,11 +216,7 @@ static struct atmel_nand_data __initdata eb_nand_data = {
 /*	.rdy_pin	= AT91_PIN_PC16, */
 	.enable_pin	= AT91_PIN_PA15,
 	.partition_info	= nand_partitions,
-#if defined(CONFIG_MTD_NAND_AT91_BUSWIDTH_16)
-	.bus_width_16	= 1,
-#else
 	.bus_width_16	= 0,
-#endif
 };
 
 static struct sam9_smc_config __initdata eb_nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index ee80059..49ef850 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -135,11 +135,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC8,
 	.enable_pin	= AT91_PIN_PC14,
 	.partition_info	= nand_partitions,
-#if defined(CONFIG_MTD_NAND_AT91_BUSWIDTH_16)
-	.bus_width_16	= 1,
-#else
 	.bus_width_16	= 0,
-#endif
 };
 
 static struct sam9_smc_config __initdata ek_nand_smc_config = {
-- 
1.7.0.4
