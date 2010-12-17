From: govindraj.raja@ti.com (Govindraj.R)
Date: Fri, 17 Dec 2010 18:41:38 +0530 (IST)
Subject: [PATCH] OMAP3: clocks: Update clock domain name for mcspi fck
Message-ID: <51292.10.24.255.18.1292591498.squirrel@dbdmail.itg.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Charulatha V <charu@ti.com>

Update clock3xxx_data for mcspi1-4 with appropriate clock domain name.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
This Patch is posted seperatley from v2_mcspi_hwmod
patch series based on comments from Paul.
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg39655.html

 arch/arm/mach-omap2/clock3xxx_data.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 0579604..9337355 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1558,6 +1558,7 @@ static struct clk mcspi4_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };

 static struct clk mcspi3_fck = {
@@ -1567,6 +1568,7 @@ static struct clk mcspi3_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };

 static struct clk mcspi2_fck = {
@@ -1576,6 +1578,7 @@ static struct clk mcspi2_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };

 static struct clk mcspi1_fck = {
@@ -1585,6 +1588,7 @@ static struct clk mcspi1_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };

 static struct clk uart2_fck = {
-- 
1.7.1
