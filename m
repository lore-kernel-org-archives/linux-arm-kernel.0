From: rogerio.pimentel@freescale.com (Rogerio Pimentel)
Date: Fri, 9 Sep 2011 17:00:06 -0300
Subject: [PATCH v2 2/4] ARM: mx53: Add clock for flexcan
In-Reply-To: <1315598408-29563-1-git-send-email-rogerio.pimentel@freescale.com>
References: <1315598408-29563-1-git-send-email-rogerio.pimentel@freescale.com>
Message-ID: <1315598408-29563-2-git-send-email-rogerio.pimentel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding clock for flexcan on i.MX53

Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
---
Changes since v1: No changes
 arch/arm/mach-mx5/clock-mx51-mx53.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index afecd78..3ae8ac0 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1422,6 +1422,12 @@ DEFINE_CLOCK(ipu_di1_clk, 0, MXC_CCM_CCGR6, MXC_CCM_CCGRx_CG6_OFFSET,
 DEFINE_CLOCK(pata_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG0_OFFSET,
 		NULL, NULL, &ipg_clk, &spba_clk);
 
+/* CAN */
+DEFINE_CLOCK(can1_clk, 0, MXC_CCM_CCGR6, MXC_CCM_CCGRx_CG10_OFFSET,
+		NULL, NULL, &ipg_clk, NULL);
+DEFINE_CLOCK(can2_clk, 1, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG3_OFFSET,
+		NULL, NULL, &ipg_clk, NULL);
+
 #define _REGISTER_CLOCK(d, n, c) \
        { \
 		.dev_id = d, \
@@ -1513,6 +1519,8 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
 	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
 	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
+	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
+	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
 };
 
 static void clk_tree_init(void)
-- 
1.7.1
