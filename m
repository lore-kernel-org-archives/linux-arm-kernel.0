From: luka@openwrt.org (Luka Perkov)
Date: Thu,  5 Sep 2013 23:13:05 +0200
Subject: [PATCH] ARM: cns3xxx: whitespace cleanup
Message-ID: <1378415585-23767-1-git-send-email-luka@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Luka Perkov <luka@openwrt.org>
---
 arch/arm/mach-cns3xxx/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index e38b279..26449a2 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -324,19 +324,19 @@ static void __init cns3xxx_init(void)
 	dn = of_find_compatible_node(NULL, NULL, "cavium,cns3420-ahci");
 	if (of_device_is_available(dn)) {
 		u32 tmp;
-	
+
 		tmp = __raw_readl(MISC_SATA_POWER_MODE);
 		tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
 		tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
 		__raw_writel(tmp, MISC_SATA_POWER_MODE);
-	
+
 		/* Enable SATA PHY */
 		cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
 		cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
-	
+
 		/* Enable SATA Clock */
 		cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
-	
+
 		/* De-Asscer SATA Reset */
 		cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
 	}
@@ -345,11 +345,11 @@ static void __init cns3xxx_init(void)
 	if (of_device_is_available(dn)) {
 		u32 __iomem *gpioa = IOMEM(CNS3XXX_MISC_BASE_VIRT + 0x0014);
 		u32 gpioa_pins = __raw_readl(gpioa);
-	
+
 		/* MMC/SD pins share with GPIOA */
 		gpioa_pins |= 0x1fff0004;
 		__raw_writel(gpioa_pins, gpioa);
-	
+
 		cns3xxx_pwr_clk_en(CNS3XXX_PWR_CLK_EN(SDIO));
 		cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SDIO));
 	}
-- 
1.8.4
