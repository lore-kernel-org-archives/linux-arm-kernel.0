From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 11 Feb 2011 19:51:28 +0530
Subject: [PATCH 1/1] davinci: changed SRAM allocator to shared ram.
Message-ID: <1297434088-27995-1-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the sram allocator to allocate memory
from the DA8XX shared RAM.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 arch/arm/mach-davinci/da850.c              |    6 +++---
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 3443d97..8a4de97 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -711,7 +711,7 @@ static struct map_desc da850_io_desc[] = {
 	},
 	{
 		.virtual	= SRAM_VIRT,
-		.pfn		= __phys_to_pfn(DA8XX_ARM_RAM_BASE),
+		.pfn		= __phys_to_pfn(DA8XX_SHARED_RAM_BASE),
 		.length		= SZ_8K,
 		.type		= MT_DEVICE
 	},
@@ -1083,8 +1083,8 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
 	.serial_dev		= &da8xx_serial_device,
 	.emac_pdata		= &da8xx_emac_pdata,
-	.sram_dma		= DA8XX_ARM_RAM_BASE,
-	.sram_len		= SZ_8K,
+	.sram_dma		= DA8XX_SHARED_RAM_BASE,
+	.sram_len		= SZ_128K,
 	.reset_device		= &da8xx_wdt_device,
 };
 
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index cfcb223..c3c3339 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -70,6 +70,7 @@ extern unsigned int da850_max_speed;
 #define DA8XX_AEMIF_CTL_BASE	0x68000000
 #define DA8XX_DDR2_CTL_BASE	0xb0000000
 #define DA8XX_ARM_RAM_BASE	0xffff0000
+#define DA8XX_SHARED_RAM_BASE	0x80000000
 
 void __init da830_init(void);
 void __init da850_init(void);
-- 
1.7.2.3
