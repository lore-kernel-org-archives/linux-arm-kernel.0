From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:43 -0300
Subject: [PATCH 16/17] ARM: mach-imx: src: Include "common.h
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-16-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warnings:

arch/arm/mach-imx/src.c:28:6: warning: symbol 'imx_enable_cpu' was not declared. Should it be static?
arch/arm/mach-imx/src.c:39:6: warning: symbol 'imx_set_cpu_jump' was not declared. Should it be static?
arch/arm/mach-imx/src.c:46:6: warning: symbol 'imx_src_prepare_restart' was not declared. Should it be static?
arch/arm/mach-imx/src.c:59:13: warning: symbol 'imx_src_init' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/src.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index e15f155..648634d 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/smp.h>
 #include <asm/smp_plat.h>
+#include "common.h"
 
 #define SRC_SCR				0x000
 #define SRC_GPR1			0x020
-- 
1.7.9.5
