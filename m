From: rob.lee@linaro.org (Robert Lee)
Date: Mon,  5 Dec 2011 22:38:10 -0600
Subject: [RFC PATCH 7/8] ARM: imx: Add mx5 clock changes necessary for low
 power
In-Reply-To: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1323146291-10676-8-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mx5 clock changes necessary to enter low power operating modes.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 4cb2769..12c8a2b 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1533,6 +1533,7 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx53-ahci.0", "ahci", sata_clk)
 	_REGISTER_CLOCK("imx53-ahci.0", "ahci_phy", ahci_phy_clk)
 	_REGISTER_CLOCK("imx53-ahci.0", "ahci_dma", ahci_dma_clk)
+	_REGISTER_CLOCK(NULL, "gpc_dvfs", gpc_dvfs_clk)
 };
 
 static void clk_tree_init(void)
@@ -1572,6 +1573,7 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 
 	clk_enable(&cpu_clk);
 	clk_enable(&main_bus_clk);
+	clk_enable(&gpc_dvfs_clk);
 
 	clk_enable(&iim_clk);
 	imx_print_silicon_rev("i.MX51", mx51_revision());
@@ -1615,6 +1617,7 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 	clk_set_parent(&uart_root_clk, &pll3_sw_clk);
 	clk_enable(&cpu_clk);
 	clk_enable(&main_bus_clk);
+	clk_enable(&gpc_dvfs_clk);
 
 	clk_enable(&iim_clk);
 	imx_print_silicon_rev("i.MX53", mx53_revision());
-- 
1.7.1
