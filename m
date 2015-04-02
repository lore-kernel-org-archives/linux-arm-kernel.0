From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  2 Apr 2015 19:23:31 -0300
Subject: [PATCH] ARM: imx: clk-cpu: Include "clk.h" header file
Message-ID: <1428013412-7082-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Include the "clk.h" header file to fix the following sparse warning:

arch/arm/mach-imx/clk-cpu.c:77:12: warning: symbol 'imx_clk_cpu' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/clk-cpu.c b/arch/arm/mach-imx/clk-cpu.c
index aa1c345..a482e66 100644
--- a/arch/arm/mach-imx/clk-cpu.c
+++ b/arch/arm/mach-imx/clk-cpu.c
@@ -13,6 +13,8 @@
 #include <linux/clk-provider.h>
 #include <linux/slab.h>
 
+#include "clk.h"
+
 struct clk_cpu {
 	struct clk_hw	hw;
 	struct clk	*div;
-- 
1.9.1
