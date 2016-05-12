From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:06:09 +0800
Subject: [PATCH v4 12/18] arm: use of_platform_default_populate() to populate
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-13-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Roland Stigge <stigge@antcom.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mach-at91/at91rm9200.c          | 2 +-
 arch/arm/mach-at91/at91sam9.c            | 2 +-
 arch/arm/mach-at91/sama5.c               | 2 +-
 arch/arm/mach-cns3xxx/core.c             | 3 +--
 arch/arm/mach-davinci/da8xx-dt.c         | 3 +--
 arch/arm/mach-imx/mach-imx6q.c           | 2 +-
 arch/arm/mach-imx/mach-imx6sl.c          | 2 +-
 arch/arm/mach-imx/mach-imx6sx.c          | 2 +-
 arch/arm/mach-integrator/integrator_ap.c | 3 +--
 arch/arm/mach-integrator/integrator_cp.c | 3 +--
 arch/arm/mach-lpc32xx/phy3250.c          | 3 +--
 arch/arm/mach-mvebu/kirkwood.c           | 2 +-
 arch/arm/mach-mxs/mach-mxs.c             | 3 +--
 arch/arm/mach-nspire/nspire.c            | 3 +--
 arch/arm/mach-orion5x/board-dt.c         | 3 +--
 arch/arm/mach-spear/spear300.c           | 3 +--
 arch/arm/mach-spear/spear310.c           | 3 +--
 arch/arm/mach-spear/spear320.c           | 3 +--
 arch/arm/mach-spear/spear6xx.c           | 3 +--
 arch/arm/mach-tegra/tegra.c              | 2 +-
 arch/arm/mach-u300/core.c                | 3 +--
 arch/arm/mach-versatile/versatile_dt.c   | 3 +--
 arch/arm/mach-zynq/common.c              | 2 +-
 23 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 63b4fa2..d068ec3 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -30,7 +30,7 @@ static void __init at91rm9200_dt_device_init(void)
 	if (soc != NULL)
 		soc_dev = soc_device_to_device(soc);
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
+	of_platform_default_populate(NULL, NULL, soc_dev);
 
 	at91rm9200_pm_init();
 }
diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index cada2a6..ba28e9c 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -61,7 +61,7 @@ static void __init at91sam9_common_init(void)
 	if (soc != NULL)
 		soc_dev = soc_device_to_device(soc);
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
+	of_platform_default_populate(NULL, NULL, soc_dev);
 }
 
 static void __init at91sam9_dt_device_init(void)
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index df8fdf1..c7d17df 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -50,7 +50,7 @@ static void __init sama5_dt_device_init(void)
 	if (soc != NULL)
 		soc_dev = soc_device_to_device(soc);
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
+	of_platform_default_populate(NULL, NULL, soc_dev);
 	sama5_pm_init();
 }
 
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 9b1dc22..03da381 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -395,8 +395,7 @@ static void __init cns3xxx_init(void)
 
 	pm_power_off = cns3xxx_power_off;
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-                        cns3xxx_auxdata, NULL);
+	of_platform_default_populate(NULL, cns3xxx_auxdata, NULL);
 }
 
 static const char *const cns3xxx_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index c4b5808..da46dc7 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -54,8 +54,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 
 static void __init da850_init_machine(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     da850_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
 
 }
 
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index cb27d56..e394070 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -278,7 +278,7 @@ static void __init imx6q_init_machine(void)
 
 	imx6q_enet_phy_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+	of_platform_default_populate(NULL, NULL, parent);
 
 	imx_anatop_init();
 	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 3003263..37ae87d 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -52,7 +52,7 @@ static void __init imx6sl_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+	of_platform_default_populate(NULL, NULL, parent);
 
 	imx6sl_fec_init();
 	imx_anatop_init();
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index 6a0b061..107cfc1 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -72,7 +72,7 @@ static void __init imx6sx_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+	of_platform_default_populate(NULL, NULL, parent);
 
 	imx6sx_enet_init();
 	imx_anatop_init();
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 5b0e363..4c2facd 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -302,8 +302,7 @@ static void __init ap_init_of(void)
 	if (!ebi_base)
 		return;
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			ap_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, ap_auxdata_lookup, NULL);
 
 	sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
 	for (i = 0; i < 4; i++) {
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index b5fb71a..31d893e 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -282,8 +282,7 @@ static void __init intcp_init_of(void)
 	if (!intcp_con_base)
 		return;
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     intcp_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, intcp_auxdata_lookup, NULL);
 }
 
 static const char * intcp_dt_board_compat[] = {
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index b2f9e22..c6ec7ba 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -191,8 +191,7 @@ static void __init lpc3250_machine_init(void)
 		LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN,
 		LPC32XX_CLKPWR_TEST_CLK_SEL);
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     lpc32xx_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, lpc32xx_auxdata_lookup, NULL);
 }
 
 static const char *const lpc32xx_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index f9d8e1e..8f459ee 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -179,7 +179,7 @@ static void __init kirkwood_dt_init(void)
 	kirkwood_pm_init();
 	kirkwood_dt_eth_fixup();
 
-	of_platform_populate(NULL, of_default_bus_match_table, auxdata, NULL);
+	of_platform_default_populate(NULL, auxdata, NULL);
 }
 
 static const char * const kirkwood_dt_board_compat[] __initconst = {
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index f1ea470..0b7fe74 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -498,8 +498,7 @@ static void __init mxs_machine_init(void)
 	else if (of_machine_is_compatible("msr,m28cu3"))
 		m28cu3_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     NULL, parent);
+	of_platform_default_populate(NULL, NULL, parent);
 
 	mxs_restart_init();
 
diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 34c2a1b3..f0808fc 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -57,8 +57,7 @@ static struct of_dev_auxdata nspire_auxdata[] __initdata = {
 
 static void __init nspire_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			nspire_auxdata, NULL);
+	of_platform_default_populate(NULL, nspire_auxdata, NULL);
 }
 
 static void nspire_restart(enum reboot_mode mode, const char *cmd)
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index 6f4c2c4..3d36f1d 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -63,8 +63,7 @@ static void __init orion5x_dt_init(void)
 	if (of_machine_is_compatible("maxtor,shared-storage-2"))
 		mss2_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     orion5x_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, orion5x_auxdata_lookup, NULL);
 }
 
 static const char *orion5x_dt_compat[] = {
diff --git a/arch/arm/mach-spear/spear300.c b/arch/arm/mach-spear/spear300.c
index 5b32edd..325b895 100644
--- a/arch/arm/mach-spear/spear300.c
+++ b/arch/arm/mach-spear/spear300.c
@@ -194,8 +194,7 @@ static void __init spear300_dt_init(void)
 	pl080_plat_data.slave_channels = spear300_dma_info;
 	pl080_plat_data.num_slave_channels = ARRAY_SIZE(spear300_dma_info);
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			spear300_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, spear300_auxdata_lookup, NULL);
 }
 
 static const char * const spear300_dt_board_compat[] = {
diff --git a/arch/arm/mach-spear/spear310.c b/arch/arm/mach-spear/spear310.c
index 86a44ac..59e173d 100644
--- a/arch/arm/mach-spear/spear310.c
+++ b/arch/arm/mach-spear/spear310.c
@@ -236,8 +236,7 @@ static void __init spear310_dt_init(void)
 	pl080_plat_data.slave_channels = spear310_dma_info;
 	pl080_plat_data.num_slave_channels = ARRAY_SIZE(spear310_dma_info);
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			spear310_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, spear310_auxdata_lookup, NULL);
 }
 
 static const char * const spear310_dt_board_compat[] = {
diff --git a/arch/arm/mach-spear/spear320.c b/arch/arm/mach-spear/spear320.c
index d45d751..0958f68 100644
--- a/arch/arm/mach-spear/spear320.c
+++ b/arch/arm/mach-spear/spear320.c
@@ -240,8 +240,7 @@ static void __init spear320_dt_init(void)
 	pl080_plat_data.slave_channels = spear320_dma_info;
 	pl080_plat_data.num_slave_channels = ARRAY_SIZE(spear320_dma_info);
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			spear320_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, spear320_auxdata_lookup, NULL);
 }
 
 static const char * const spear320_dt_board_compat[] = {
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index da26fa5b..ccf3573 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -411,8 +411,7 @@ struct of_dev_auxdata spear6xx_auxdata_lookup[] __initdata = {
 
 static void __init spear600_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			spear6xx_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, spear6xx_auxdata_lookup, NULL);
 }
 
 static const char *spear600_dt_board_compat[] = {
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 2378fa56..6745a65 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -115,7 +115,7 @@ static void __init tegra_dt_init(void)
 	 * devices
 	 */
 out:
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+	of_platform_default_populate(NULL, NULL, parent);
 }
 
 static void __init paz00_init(void)
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 546338b..a4910ea 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -391,8 +391,7 @@ static void __init u300_init_machine_dt(void)
 	pinctrl_register_mappings(u300_pinmux_map,
 				  ARRAY_SIZE(u300_pinmux_map));
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			u300_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, u300_auxdata_lookup, NULL);
 
 	/* Enable SEMI self refresh */
 	val = readw(syscon_base + U300_SYSCON_SMCR) |
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index dff1c05..efcf7b9 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -391,8 +391,7 @@ static void __init versatile_dt_init(void)
 	versatile_dt_pci_init();
 
 	platform_device_register(&versatile_flash_device);
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     versatile_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, versatile_auxdata_lookup, NULL);
 }
 
 static const char *const versatile_dt_match[] __initconst = {
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 860ffb6..06abe29 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -142,7 +142,7 @@ out:
 	 * Finished with the static registrations now; fill in the missing
 	 * devices
 	 */
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
+	of_platform_default_populate(NULL, NULL, parent);
 
 	platform_device_register(&zynq_cpuidle_device);
 	platform_device_register_full(&devinfo);
-- 
1.7.12.4
