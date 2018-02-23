From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri, 23 Feb 2018 14:37:34 +0100
Subject: [PATCH v4 02/10] ARM: sun9i: smp: Rename clusters's power-off register
In-Reply-To: <20180223133742.26044-1-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
Message-ID: <20180223133742.26044-3-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare the support for sun8i-a83t, rename the variable name
that handles the power-off of clusters because it is different from
sun9i-a80 to sun8i-a83t.

The power off register for clusters are different from SUN9I and SUN8I

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/mc_smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 650a2ad4398f..de02e5662557 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -60,7 +60,7 @@
 #define PRCM_CPU_PO_RST_CTRL_CORE(n)	BIT(n)
 #define PRCM_CPU_PO_RST_CTRL_CORE_ALL	0xf
 #define PRCM_PWROFF_GATING_REG(c)	(0x100 + 0x4 * (c))
-#define PRCM_PWROFF_GATING_REG_CLUSTER	BIT(4)
+#define PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I	BIT(4)
 #define PRCM_PWROFF_GATING_REG_CORE(n)	BIT(n)
 #define PRCM_PWR_SWITCH_REG(c, cpu)	(0x140 + 0x10 * (c) + 0x4 * (cpu))
 #define PRCM_CPU_SOFT_ENTRY_REG		0x164
@@ -252,7 +252,7 @@ static int sunxi_cluster_powerup(unsigned int cluster)
 
 	/* clear cluster power gate */
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
-	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER;
+	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
@@ -516,7 +516,7 @@ static int sunxi_cluster_powerdown(unsigned int cluster)
 	/* gate cluster power */
 	pr_debug("%s: gate cluster power\n", __func__);
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
-	reg |= PRCM_PWROFF_GATING_REG_CLUSTER;
+	reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
-- 
2.11.0
