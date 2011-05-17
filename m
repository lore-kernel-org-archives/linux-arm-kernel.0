From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue, 17 May 2011 17:42:05 -0400
Subject: [PATCH 9/9] davinci: da850: changed SRAM allocator to shared ram.
In-Reply-To: <cover.1305668470.git.bengardiner@nanometrics.ca>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
	<cover.1305668470.git.bengardiner@nanometrics.ca>
Message-ID: <e6e7b13ce98f0216bbd714fb6a4f11effcbc721d.1305668470.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Subhasish Ghosh <subhasish@mistralsolutions.com>

This patch modifies the sram allocator to allocate memory
from the DA8XX shared RAM.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
[rebased onto consolidated SRAM patches]
Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 arch/arm/mach-davinci/da850.c              |    4 ++--
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 5754338..cdb7e77 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1093,8 +1093,8 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
 	.serial_dev		= &da8xx_serial_device,
 	.emac_pdata		= &da8xx_emac_pdata,
-	.sram_phys		= DA8XX_ARM_RAM_BASE,
-	.sram_len		= SZ_8K,
+	.sram_phys		= DA8XX_SHARED_RAM_BASE,
+	.sram_len		= SZ_128K,
 	.reset_device		= &da8xx_wdt_device,
 };
 
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index e4fc1af..09b8ddb 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -72,6 +72,7 @@ extern unsigned int da850_max_speed;
 #define DA8XX_AEMIF_CTL_BASE	0x68000000
 #define DA8XX_DDR2_CTL_BASE	0xb0000000
 #define DA8XX_ARM_RAM_BASE	0xffff0000
+#define DA8XX_SHARED_RAM_BASE	0x80000000
 
 void __init da830_init(void);
 void __init da850_init(void);
-- 
1.7.4.1
