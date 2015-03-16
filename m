From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 16 Mar 2015 20:54:41 +0100
Subject: [PATCH 31/35 linux-next] EDAC: constify of_device_id array
In-Reply-To: <1426535685-25996-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-1-git-send-email-fabf@skynet.be>
Message-ID: <1426535685-25996-10-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/edac/highbank_mc_edac.c | 2 +-
 drivers/edac/mpc85xx_edac.c     | 4 ++--
 drivers/edac/ppc4xx_edac.c      | 2 +-
 drivers/edac/synopsys_edac.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_edac.c
index 4754847..11260cc 100644
--- a/drivers/edac/highbank_mc_edac.c
+++ b/drivers/edac/highbank_mc_edac.c
@@ -146,7 +146,7 @@ static struct hb_mc_settings mw_settings = {
 	.int_offset = MW_DDR_ECC_INT_BASE,
 };
 
-static struct of_device_id hb_ddr_ctrl_of_match[] = {
+static const struct of_device_id hb_ddr_ctrl_of_match[] = {
 	{ .compatible = "calxeda,hb-ddr-ctrl",		.data = &hb_settings },
 	{ .compatible = "calxeda,ecx-2000-ddr-ctrl",	.data = &mw_settings },
 	{},
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 7be979c..68bf234 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -670,7 +670,7 @@ static int mpc85xx_l2_err_remove(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id mpc85xx_l2_err_of_match[] = {
+static const struct of_device_id mpc85xx_l2_err_of_match[] = {
 /* deprecate the fsl,85.. forms in the future, 2.6.30? */
 	{ .compatible = "fsl,8540-l2-cache-controller", },
 	{ .compatible = "fsl,8541-l2-cache-controller", },
@@ -1160,7 +1160,7 @@ static int mpc85xx_mc_err_remove(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id mpc85xx_mc_err_of_match[] = {
+static const struct of_device_id mpc85xx_mc_err_of_match[] = {
 /* deprecate the fsl,85.. forms in the future, 2.6.30? */
 	{ .compatible = "fsl,8540-memory-controller", },
 	{ .compatible = "fsl,8541-memory-controller", },
diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
index 1b64fd0..3515b38 100644
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -193,7 +193,7 @@ static int ppc4xx_edac_remove(struct platform_device *device);
  * Device tree node type and compatible tuples this driver can match
  * on.
  */
-static struct of_device_id ppc4xx_edac_match[] = {
+static const struct of_device_id ppc4xx_edac_match[] = {
 	{
 		.compatible	= "ibm,sdram-4xx-ddr2"
 	},
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 1c96915..fc153ae 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -512,7 +512,7 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id synps_edac_match[] = {
+static const struct of_device_id synps_edac_match[] = {
 	{ .compatible = "xlnx,zynq-ddrc-a05", },
 	{ /* end of table */ }
 };
-- 
2.1.0
