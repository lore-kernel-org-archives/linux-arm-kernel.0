From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Wed,  1 Jun 2011 11:03:25 -0400
Subject: [PATCH 3/3] [v3] davinci: da850: changed SRAM allocator to shared ram.
In-Reply-To: <cover.1306940448.git.bengardiner@nanometrics.ca>
References: <20110601051753.GA5153@game.jcrosoft.org>
	<cover.1306940448.git.bengardiner@nanometrics.ca>
Message-ID: <9abf8b57b0b664ffc262af63bd0495e9d7c09230.1306940448.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Subhasish Ghosh <subhasish@mistralsolutions.com>

This patch modifies the sram allocator to allocate memory
from the DA8XX shared RAM.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
[rebased onto consolidated SRAM patches]
Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Reviewed-by: Sergei Shtylyov <sshtylyov@mvista.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

---
Changes since v2:
 * Added Jean-Christophe PLAGNIOL-VILLARD's Ack
Changes since v1:
 * re-sorted the new DA8XX_SHARED_RAM_BASE definition in  da8xx.h
   to between DA8XX_AEMIF_CTL_BASE and DA8XX_DDR2_CTL_BASE (Sergei
   Shtylyov).

---
 arch/arm/mach-davinci/da850.c              |    4 ++--
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 904ede9..4781230 100644
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
index ad64da7..b67499f 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -67,6 +67,7 @@ extern unsigned int da850_max_speed;
 #define DA8XX_AEMIF_CS2_BASE	0x60000000
 #define DA8XX_AEMIF_CS3_BASE	0x62000000
 #define DA8XX_AEMIF_CTL_BASE	0x68000000
+#define DA8XX_SHARED_RAM_BASE	0x80000000
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
 void __init da830_init(void);
-- 
1.7.4.1
