From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 22 Aug 2011 12:36:16 -0300
Subject: [PATCH 1/2] ARM: mx25: Add iim clock support
Message-ID: <1314027377-15915-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for IIM (IC Identification Module) clock.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clock-imx25.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index a65838f..b919ad8 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -263,6 +263,7 @@ DEFINE_CLOCK(audmux_clk, 0, CCM_CGCR1, 0, NULL, NULL, NULL);
 DEFINE_CLOCK(csi_clk,    0, CCM_CGCR1,  4, get_rate_csi, NULL,  &csi_per_clk);
 DEFINE_CLOCK(can1_clk,	 0, CCM_CGCR1,  2, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(can2_clk,	 1, CCM_CGCR1,  3, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(iim_clk, 0, CCM_CGCR1, 26, NULL, NULL, NULL);
 
 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
@@ -307,6 +308,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
 	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
 	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
+	_REGISTER_CLOCK(NULL, "iim", iim_clk)
 };
 
 int __init mx25_clocks_init(void)
-- 
1.7.1
