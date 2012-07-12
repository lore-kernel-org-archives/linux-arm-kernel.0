From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 12 Jul 2012 19:39:31 +0400
Subject: [PATCH v2 4/4] ARM: i.MX5x CSPI: Fixed clock name for CSPI
In-Reply-To: <1342107571-15454-1-git-send-email-shc_work@mail.ru>
References: <1342107571-15454-1-git-send-email-shc_work@mail.ru>
Message-ID: <1342107571-15454-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch also includes fix CSPI ID for i.MX53. ID should be 2,
because IDs 0 and 1 are occupied by eCSPI.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx51-imx53.c          |    2 +-
 arch/arm/plat-mxc/devices/platform-spi_imx.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 3d7564c..b0cf835 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -253,7 +253,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[ecspi1_ipg_gate], "ipg", "imx51-ecspi.0");
 	clk_register_clkdev(clk[ecspi2_per_gate], "per", "imx51-ecspi.1");
 	clk_register_clkdev(clk[ecspi2_ipg_gate], "ipg", "imx51-ecspi.1");
-	clk_register_clkdev(clk[cspi_ipg_gate], NULL, "imx51-cspi.0");
+	clk_register_clkdev(clk[cspi_ipg_gate], NULL, "imx35-cspi.2");
 	clk_register_clkdev(clk[pwm1_ipg_gate], "pwm", "mxc_pwm.0");
 	clk_register_clkdev(clk[pwm2_ipg_gate], "pwm", "mxc_pwm.1");
 	clk_register_clkdev(clk[i2c1_gate], NULL, "imx-i2c.0");
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index 9bfae8b..9c50c14 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -95,7 +95,7 @@ const struct imx_spi_imx_data imx51_ecspi_data[] __initconst = {
 #ifdef CONFIG_SOC_IMX53
 /* i.mx53 has the i.mx35 type cspi */
 const struct imx_spi_imx_data imx53_cspi_data __initconst =
-	imx_spi_imx_data_entry_single(MX53, CSPI, "imx35-cspi", 0, , SZ_4K);
+	imx_spi_imx_data_entry_single(MX53, CSPI, "imx35-cspi", 2, , SZ_4K);
 
 /* i.mx53 has the i.mx51 type ecspi */
 const struct imx_spi_imx_data imx53_ecspi_data[] __initconst = {
-- 
1.7.3.4
