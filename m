From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 May 2014 16:45:37 +0800
Subject: [PATCH 19/20] ARM: imx5: clean function declarations in mx51.h
In-Reply-To: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
References: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1400575538-21136-20-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mx51_display_revision() is a dead declaration.  Remove it.  Also,
move mx51_revision() into common.h.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/common.h | 1 +
 arch/arm/mach-imx/mx51.h   | 5 -----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 53ee569..5aaea2b 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -64,6 +64,7 @@ void mxc_set_cpu_type(unsigned int type);
 void mxc_restart(enum reboot_mode, const char *);
 void mxc_arch_reset_init(void __iomem *);
 void mxc_arch_reset_init_dt(void);
+int mx51_revision(void);
 int mx53_revision(void);
 void imx_set_aips(void __iomem *);
 int mxc_device_init(void);
diff --git a/arch/arm/mach-imx/mx51.h b/arch/arm/mach-imx/mx51.h
index 3f6d4a6..a569528 100644
--- a/arch/arm/mach-imx/mx51.h
+++ b/arch/arm/mach-imx/mx51.h
@@ -305,9 +305,4 @@
 #define MX51_INT_EMI_NFC		(NR_IRQS_LEGACY + 101)
 #define MX51_INT_GPU_IDLE		(NR_IRQS_LEGACY + 102)
 
-#if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
-extern int mx51_revision(void);
-extern void mx51_display_revision(void);
-#endif
-
 #endif	/* ifndef __MACH_MX51_H__ */
-- 
1.8.3.2
