From: keshava_mgowda@ti.com (Munegowda, Keshava)
Date: Wed, 5 May 2010 17:40:16 +0530
Subject: [PATCH]omap:mux.c waring removal
Message-ID: <0680EC522D0CC943BC586913CF3768C003B3165175@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Keshava Munegowda <a0393220@ti.com>

This patch removes the below warning 
arch/arm/mach-omap2/mux.c:52: warning: 'mux_phys' defined but not used
The definition of variable mux_phys should be enclosed in the macro CONFIG_ARCH_OMAP3 

Signed-off-by: Keshava Munegowda <a0393220@ti.com>
Index: linux-2.6/arch/arm/mach-omap2/mux.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/mux.c	2010-05-05 05:28:47.000000000 +0530
+++ linux-2.6/arch/arm/mach-omap2/mux.c	2010-05-05 05:29:02.000000000 +0530
@@ -49,7 +49,9 @@
 	struct list_head	node;
 };
 
+#ifdef CONFIG_ARCH_OMAP3
 static unsigned long mux_phys;
+#endif
 static void __iomem *mux_base;
 
 u16 omap_mux_read(u16 reg)

Regards,
Keshava Munegowda


?
?
?
