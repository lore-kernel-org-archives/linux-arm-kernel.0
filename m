From: tony@atomide.com (Tony Lindgren)
Date: Thu, 08 Jul 2010 16:54:43 +0300
Subject: [PATCH 05/13] omap2/3: id: fix sparse warning
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Message-ID: <20100708135443.26276.42605.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

omap24xx_check_revision, omap3_check_features,
omap3_check_revision, omap4_check_revision, omap3_cpuinfo
are not used elsewhere, it should be static

Also fixes the following sparse warnings:
arch/arm/mach-omap2/id.c:105:13: warning: symbol 'omap24xx_check_revision'
was not declared. Should it be static?
arch/arm/mach-omap2/id.c:167:13: warning: symbol 'omap3_check_features'
was not declared. Should it be static?
arch/arm/mach-omap2/id.c:189:13: warning: symbol 'omap3_check_revision'
was not declared. Should it be static?
arch/arm/mach-omap2/id.c:270:13: warning: symbol 'omap4_check_revision'
was not declared. Should it be static?
arch/arm/mach-omap2/id.c:300:13: warning: symbol 'omap3_cpuinfo'
was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37b8a1a..c7bf0e1 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -102,7 +102,7 @@ static struct omap_id omap_ids[] __initdata = {
 static void __iomem *tap_base;
 static u16 tap_prod_id;
 
-void __init omap24xx_check_revision(void)
+static void __init omap24xx_check_revision(void)
 {
 	int i, j;
 	u32 idcode, prod_id;
@@ -164,7 +164,7 @@ void __init omap24xx_check_revision(void)
 		omap3_features |= OMAP3_HAS_ ##feat;			\
 	}
 
-void __init omap3_check_features(void)
+static void __init omap3_check_features(void)
 {
 	u32 status;
 
@@ -186,7 +186,7 @@ void __init omap3_check_features(void)
 	 */
 }
 
-void __init omap3_check_revision(void)
+static void __init omap3_check_revision(void)
 {
 	u32 cpuid, idcode;
 	u16 hawkeye;
@@ -267,7 +267,7 @@ void __init omap3_check_revision(void)
 	}
 }
 
-void __init omap4_check_revision(void)
+static void __init omap4_check_revision(void)
 {
 	u32 idcode;
 	u16 hawkeye;
@@ -297,7 +297,7 @@ void __init omap4_check_revision(void)
 	if (omap3_has_ ##feat())		\
 		printk(#feat" ");
 
-void __init omap3_cpuinfo(void)
+static void __init omap3_cpuinfo(void)
 {
 	u8 rev = GET_OMAP_REVISION();
 	char cpu_name[16], cpu_rev[16];
