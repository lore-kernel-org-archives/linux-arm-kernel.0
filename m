From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 20:57:10 +0530
Subject: [PATCH 4/8] ARM: OMAP5: Reuse prm read_inst/write_inst
In-Reply-To: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1361374034-21831-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <t-kristo@ti.com>

Make use of 'prm_base' so that  prm read_inst/write_inst can work on
OMAP5 devices.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 1aae198..cb24b26 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -81,13 +81,13 @@ static struct prm_reset_src_map omap44xx_prm_reset_src_map[] = {
 /* Read a register in a CM/PRM instance in the PRM module */
 u32 omap4_prm_read_inst_reg(s16 inst, u16 reg)
 {
-	return __raw_readl(OMAP44XX_PRM_REGADDR(inst, reg));
+	return __raw_readl(prm_base + inst + reg);
 }
 
 /* Write into a register in a CM/PRM instance in the PRM module */
 void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 reg)
 {
-	__raw_writel(val, OMAP44XX_PRM_REGADDR(inst, reg));
+	__raw_writel(val, prm_base + inst + reg);
 }
 
 /* Read-modify-write a register in a PRM module. Caller must lock */
-- 
1.7.9.5
