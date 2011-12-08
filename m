From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  8 Dec 2011 16:28:06 +0100
Subject: [PATCH 1/1] at91: 9260 and 9g20 add support of join SRAM Memory
 Mapping
Message-ID: <1323358086-18749-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on 9269 and 9g20 the sram are mirrored at then of the bank so we can join them

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at91sam9260.c              |   13 +++++--------
 arch/arm/mach-at91/include/mach/at91sam9260.h |    4 ++++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 1836002..3ebd306 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -309,15 +309,12 @@ static void __init at91sam9xe_map_io(void)
 
 static void __init at91sam9260_map_io(void)
 {
-	if (cpu_is_at91sam9xe()) {
+	if (cpu_is_at91sam9xe())
 		at91sam9xe_map_io();
-	} else if (cpu_is_at91sam9g20()) {
-		at91_init_sram(0, AT91SAM9G20_SRAM0_BASE, AT91SAM9G20_SRAM0_SIZE);
-		at91_init_sram(1, AT91SAM9G20_SRAM1_BASE, AT91SAM9G20_SRAM1_SIZE);
-	} else {
-		at91_init_sram(0, AT91SAM9260_SRAM0_BASE, AT91SAM9260_SRAM0_SIZE);
-		at91_init_sram(1, AT91SAM9260_SRAM1_BASE, AT91SAM9260_SRAM1_SIZE);
-	}
+	else if (cpu_is_at91sam9g20())
+		at91_init_sram(0, AT91SAM9G20_SRAM_BASE, AT91SAM9G20_SRAM_SIZE);
+	else
+		at91_init_sram(0, AT91SAM9260_SRAM_BASE, AT91SAM9260_SRAM_SIZE);
 	at91_init_gpbr(AT91SAM9260_BASE_GPBR, 16);
 }
 
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 23fdede..e3cb780 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -115,6 +115,8 @@
 #define AT91SAM9260_SRAM0_SIZE	SZ_4K		/* Internal SRAM 0 size (4Kb) */
 #define AT91SAM9260_SRAM1_BASE	0x00300000	/* Internal SRAM 1 base address */
 #define AT91SAM9260_SRAM1_SIZE	SZ_4K		/* Internal SRAM 1 size (4Kb) */
+#define AT91SAM9260_SRAM_BASE	0x002FF000	/* Internal SRAM base address */
+#define AT91SAM9260_SRAM_SIZE	SZ_8K		/* Internal SRAM size (8Kb) */
 
 #define AT91SAM9260_UHP_BASE	0x00500000	/* USB Host controller */
 
@@ -128,6 +130,8 @@
 #define AT91SAM9G20_SRAM0_SIZE	SZ_16K		/* Internal SRAM 0 size (16Kb) */
 #define AT91SAM9G20_SRAM1_BASE	0x00300000	/* Internal SRAM 1 base address */
 #define AT91SAM9G20_SRAM1_SIZE	SZ_16K		/* Internal SRAM 1 size (16Kb) */
+#define AT91SAM9G20_SRAM_BASE	0x002FC000	/* Internal SRAM base address */
+#define AT91SAM9G20_SRAM_SIZE	SZ_32K		/* Internal SRAM size (32Kb) */
 
 #define AT91SAM9G20_UHP_BASE	0x00500000	/* USB Host controller */
 
-- 
1.7.7
