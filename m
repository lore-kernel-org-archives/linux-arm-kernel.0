From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 00:51:25 +0200
Subject: [patch-v2.6.33-rc2+ 05/12] arm: omap: gpmc: kill compile warning
In-Reply-To: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Message-ID: <1262127092-14878-6-git-send-email-felipe.balbi@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of the following warnings:

arch/arm/mach-omap2/gpmc.c:550:30: warning: non-ANSI
function declaration of function 'omap3_gpmc_save_context'

arch/arm/mach-omap2/gpmc.c:581:33: warning: non-ANSI
function declaration of function 'omap3_gpmc_restore_context'

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/gpmc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index bd8cb59..32f2c51 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -547,9 +547,10 @@ void __init gpmc_init(void)
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap3_gpmc_regs gpmc_context;
 
-void omap3_gpmc_save_context()
+void omap3_gpmc_save_context(void)
 {
 	int i;
+
 	gpmc_context.sysconfig = gpmc_read_reg(GPMC_SYSCONFIG);
 	gpmc_context.irqenable = gpmc_read_reg(GPMC_IRQENABLE);
 	gpmc_context.timeout_ctrl = gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
@@ -578,9 +579,10 @@ void omap3_gpmc_save_context()
 	}
 }
 
-void omap3_gpmc_restore_context()
+void omap3_gpmc_restore_context(void)
 {
 	int i;
+
 	gpmc_write_reg(GPMC_SYSCONFIG, gpmc_context.sysconfig);
 	gpmc_write_reg(GPMC_IRQENABLE, gpmc_context.irqenable);
 	gpmc_write_reg(GPMC_TIMEOUT_CONTROL, gpmc_context.timeout_ctrl);
-- 
1.6.6.35.g1d85d
