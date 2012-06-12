From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 12 Jun 2012 14:49:46 +0200
Subject: [PATCH] ARM: pxa: remove eseries.h
Message-ID: <1339505386.30984.123.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e478fe4cd50b86e95fadc415438b63fa94060b7d ("[ARM] pxa: merge all
eseries board code into eseries.c") removed all six files that included
eseries.h. Everything that this header provides is now either local to
eseries.c or entirely unused. It was apparently just an oversight to
keep this header. This header can safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Testing with "git grep" for various things in the (history of the) tree.

 arch/arm/mach-pxa/eseries.h |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/eseries.h

diff --git a/arch/arm/mach-pxa/eseries.h b/arch/arm/mach-pxa/eseries.h
deleted file mode 100644
index b96949d..0000000
--- a/arch/arm/mach-pxa/eseries.h
+++ /dev/null
@@ -1,14 +0,0 @@
-void __init eseries_fixup(struct tag *tags, char **cmdline, struct meminfo *mi);
-
-extern struct pxa2xx_udc_mach_info e7xx_udc_mach_info;
-extern struct pxaficp_platform_data e7xx_ficp_platform_data;
-extern int e7xx_irda_init(void);
-
-extern int eseries_tmio_enable(struct platform_device *dev);
-extern int eseries_tmio_disable(struct platform_device *dev);
-extern int eseries_tmio_suspend(struct platform_device *dev);
-extern int eseries_tmio_resume(struct platform_device *dev);
-extern void eseries_get_tmio_gpios(void);
-extern struct resource eseries_tmio_resources[];
-extern struct platform_device e300_tc6387xb_device;
-
-- 
1.7.7.6
