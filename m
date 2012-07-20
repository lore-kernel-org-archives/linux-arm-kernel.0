From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 20 Jul 2012 17:20:27 +0800
Subject: [PATCH 4/4] ARM: mx28evk: add missed clkmux select for saif
In-Reply-To: <1342776027-31758-1-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
Message-ID: <1342776027-31758-5-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Added missed clkmux setting for mx28evk.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/mach-mxs/mach-mxs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 8cac94b..82f27a4 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -21,6 +21,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
+#include <mach/digctl.h>
 
 static int __init mxs_icoll_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
@@ -79,6 +80,8 @@ static void __init imx28_evk_init(void)
 	clk = clk_get_sys("enet_out", NULL);
 	if (!IS_ERR(clk))
 		clk_prepare_enable(clk);
+
+	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
 }
 
 static void __init mxs_machine_init(void)
-- 
1.7.0.4
