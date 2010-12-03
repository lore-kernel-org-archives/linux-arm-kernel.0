From: gadiyar@ti.com (Anand Gadiyar)
Date: Sat,  4 Dec 2010 00:45:30 +0530
Subject: [PATCH -next] omap2430: hwmod: remove stray declaration
Message-ID: <1291403730-3165-1-git-send-email-gadiyar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch "OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430"
in linux-next as of 20101203 introduced the following build
warning - fix this by removing the stray i2c_dev_attr.

arch/arm/mach-omap2/omap_hwmod_2430_data.c:483: warning: 'i2c_dev_attr' defined but not used

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 --
 1 file changed, 2 deletions(-)

Index: mainline/arch/arm/mach-omap2/omap_hwmod_2430_data.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ mainline/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -480,8 +480,6 @@ static struct omap_hwmod_class i2c_class
 	.sysc		= &i2c_sysc,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr;
-
 /* I2C1 */
 
 static struct omap_i2c_dev_attr i2c1_dev_attr = {
