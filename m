From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:28 -0300
Subject: [PATCH 1/17] ARM: mach-imx: cpu: Include "common.h"
Message-ID: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warnings:

arch/arm/mach-imx/cpu.c:10:6: warning: symbol 'mxc_set_cpu_type' was not declared. Should it be static?
arch/arm/mach-imx/cpu.c:15:6: warning: symbol 'imx_print_silicon_rev' was not declared. Should it be static?
arch/arm/mach-imx/cpu.c:24:13: warning: symbol 'imx_set_aips' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/cpu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 03fcbd0..e70e3ac 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -3,6 +3,7 @@
 #include <linux/io.h>
 
 #include "hardware.h"
+#include "common.h"
 
 unsigned int __mxc_cpu_type;
 EXPORT_SYMBOL(__mxc_cpu_type);
-- 
1.7.9.5
