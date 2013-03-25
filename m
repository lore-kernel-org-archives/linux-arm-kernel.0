From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:42 -0300
Subject: [PATCH 15/17] ARM: mach-imx: gpc: Include "common.h"
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-15-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warnings:

arch/arm/mach-imx/gpc.c:29:6: warning: symbol 'imx_gpc_pre_suspend' was not declared. Should it be static?
arch/arm/mach-imx/gpc.c:43:6: warning: symbol 'imx_gpc_post_resume' was not declared. Should it be static?
arch/arm/mach-imx/gpc.c:71:6: warning: symbol 'imx_gpc_mask_all' was not declared. Should it be static?
arch/arm/mach-imx/gpc.c:83:6: warning: symbol 'imx_gpc_restore_all' was not declared. Should it be static?
arch/arm/mach-imx/gpc.c:122:13: warning: symbol 'imx_gpc_init' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/gpc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index c20445c..44a65e9 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip/arm-gic.h>
+#include "common.h"
 
 #define GPC_IMR1		0x008
 #define GPC_PGC_CPU_PDN		0x2a0
-- 
1.7.9.5
