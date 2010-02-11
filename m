From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Feb 2010 19:36:07 -0800
Subject: [PATCH 12/17] omap2/3/4: gpmc: kill compile warning
In-Reply-To: <20100211033310.1624.80025.stgit@baageli.muru.com>
References: <20100211033310.1624.80025.stgit@baageli.muru.com>
Message-ID: <20100211033607.1624.87200.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <felipe.balbi@nokia.com>

Get rid of the following warnings:

arch/arm/mach-omap2/gpmc.c:550:30: warning: non-ANSI
function declaration of function 'omap3_gpmc_save_context'

arch/arm/mach-omap2/gpmc.c:581:33: warning: non-ANSI
function declaration of function 'omap3_gpmc_restore_context'

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpmc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 7027cdc..5bc3ca0 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -552,9 +552,10 @@ void __init gpmc_init(void)
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
@@ -583,9 +584,10 @@ void omap3_gpmc_save_context()
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
