From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 20 Mar 2015 20:44:33 +0200
Subject: [PATCHv5 22/35] ARM: OMAP2+: control: remove API for getting control
 module base address
In-Reply-To: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Message-ID: <1426877086-17131-23-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This shall not be used anymore, as control module driver is converted
into using regmap.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |    5 -----
 arch/arm/mach-omap2/control.h |    2 --
 2 files changed, 7 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 4b40946..202fc72 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -145,11 +145,6 @@ void __init omap2_set_globals_control(void __iomem *ctrl,
 	omap4_ctrl_pad_base = ctrl_pad;
 }
 
-void __iomem *omap_ctrl_base_get(void)
-{
-	return omap2_ctrl_base;
-}
-
 u8 omap_ctrl_readb(u16 offset)
 {
 	return readb_relaxed(OMAP_CTRL_REGADDR(offset));
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index c1057eb..5353ff4 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -440,7 +440,6 @@
 
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_ARCH_OMAP2PLUS
-extern void __iomem *omap_ctrl_base_get(void);
 extern u8 omap_ctrl_readb(u16 offset);
 extern u16 omap_ctrl_readw(u16 offset);
 extern u32 omap_ctrl_readl(u16 offset);
@@ -470,7 +469,6 @@ extern void omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad);
 void __init omap3_control_legacy_iomap_init(void);
 #else
-#define omap_ctrl_base_get()		0
 #define omap_ctrl_readb(x)		0
 #define omap_ctrl_readw(x)		0
 #define omap_ctrl_readl(x)		0
-- 
1.7.9.5
