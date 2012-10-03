From: mporter@ti.com (Matt Porter)
Date: Wed,  3 Oct 2012 10:55:30 -0400
Subject: [PATCH v3 3/6] ARM: davinci: da850: changed SRAM allocator to shared
 ram.
In-Reply-To: <1349276133-26408-1-git-send-email-mporter@ti.com>
References: <1349276133-26408-1-git-send-email-mporter@ti.com>
Message-ID: <1349276133-26408-4-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Subhasish Ghosh <subhasish@mistralsolutions.com>

This patch modifies the sram allocator to allocate memory
from the DA8XX shared RAM.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
[rebased onto consolidated SRAM patches]
Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
[rebased to mainline as consolidated SRAM patches were dropped]
Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/mach-davinci/da850.c              |    4 ++--
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index b4b324f..d8d69de 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1081,8 +1081,8 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
 	.serial_dev		= &da8xx_serial_device,
 	.emac_pdata		= &da8xx_emac_pdata,
-	.sram_dma		= DA8XX_ARM_RAM_BASE,
-	.sram_len		= SZ_8K,
+	.sram_dma		= DA8XX_SHARED_RAM_BASE,
+	.sram_len		= SZ_128K,
 };
 
 void __init da850_init(void)
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index c9ee723..20553cf 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -68,6 +68,7 @@ extern unsigned int da850_max_speed;
 #define DA8XX_AEMIF_CS2_BASE	0x60000000
 #define DA8XX_AEMIF_CS3_BASE	0x62000000
 #define DA8XX_AEMIF_CTL_BASE	0x68000000
+#define DA8XX_SHARED_RAM_BASE	0x80000000
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
 void __init da830_init(void);
-- 
1.7.9.5
