From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 16 Mar 2015 20:17:14 +0100
Subject: [PATCH 08/35 linux-next] dma: constify of_device_id array
In-Reply-To: <1426533469-25458-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Message-ID: <1426533469-25458-9-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/dma/bestcomm/bestcomm.c | 4 ++--
 drivers/dma/k3dma.c             | 2 +-
 drivers/dma/mmp_pdma.c          | 2 +-
 drivers/dma/mmp_tdma.c          | 2 +-
 drivers/dma/mpc512x_dma.c       | 2 +-
 drivers/dma/mv_xor.c            | 2 +-
 drivers/dma/sirf-dma.c          | 2 +-
 drivers/dma/sun6i-dma.c         | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
index fa378d8..180fedb 100644
--- a/drivers/dma/bestcomm/bestcomm.c
+++ b/drivers/dma/bestcomm/bestcomm.c
@@ -30,7 +30,7 @@
 #define DRIVER_NAME "bestcomm-core"
 
 /* MPC5200 device tree match tables */
-static struct of_device_id mpc52xx_sram_ids[] = {
+static const struct of_device_id mpc52xx_sram_ids[] = {
 	{ .compatible = "fsl,mpc5200-sram", },
 	{ .compatible = "mpc5200-sram", },
 	{}
@@ -481,7 +481,7 @@ static int mpc52xx_bcom_remove(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id mpc52xx_bcom_of_match[] = {
+static const struct of_device_id mpc52xx_bcom_of_match[] = {
 	{ .compatible = "fsl,mpc5200-bestcomm", },
 	{ .compatible = "mpc5200-bestcomm", },
 	{},
diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 6f7f435..3ac9256 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -654,7 +654,7 @@ static void k3_dma_free_desc(struct virt_dma_desc *vd)
 	kfree(ds);
 }
 
-static struct of_device_id k3_pdma_dt_ids[] = {
+static const struct of_device_id k3_pdma_dt_ids[] = {
 	{ .compatible = "hisilicon,k3-dma-1.0", },
 	{}
 };
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index eb41004..462a022 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -973,7 +973,7 @@ static int mmp_pdma_chan_init(struct mmp_pdma_device *pdev, int idx, int irq)
 	return 0;
 }
 
-static struct of_device_id mmp_pdma_dt_ids[] = {
+static const struct of_device_id mmp_pdma_dt_ids[] = {
 	{ .compatible = "marvell,pdma-1.0", },
 	{}
 };
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index b6f4e1f..449e785 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -613,7 +613,7 @@ struct dma_chan *mmp_tdma_xlate(struct of_phandle_args *dma_spec,
 	return dma_request_channel(mask, mmp_tdma_filter_fn, &param);
 }
 
-static struct of_device_id mmp_tdma_dt_ids[] = {
+static const struct of_device_id mmp_tdma_dt_ids[] = {
 	{ .compatible = "marvell,adma-1.0", .data = (void *)MMP_AUD_TDMA},
 	{ .compatible = "marvell,pxa910-squ", .data = (void *)PXA910_SQU},
 	{}
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 57d2457..9553a8d 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -1072,7 +1072,7 @@ static int mpc_dma_remove(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id mpc_dma_match[] = {
+static const struct of_device_id mpc_dma_match[] = {
 	{ .compatible = "fsl,mpc5121-dma", },
 	{ .compatible = "fsl,mpc8308-dma", },
 	{},
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index b03e813..9b2fa54 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1249,7 +1249,7 @@ static int mv_xor_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id mv_xor_dt_ids[] = {
+static const struct of_device_id mv_xor_dt_ids[] = {
        { .compatible = "marvell,orion-xor", },
        {},
 };
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index d0086e9..a1afda4 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -896,7 +896,7 @@ static const struct dev_pm_ops sirfsoc_dma_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sirfsoc_dma_pm_suspend, sirfsoc_dma_pm_resume)
 };
 
-static struct of_device_id sirfsoc_dma_match[] = {
+static const struct of_device_id sirfsoc_dma_match[] = {
 	{ .compatible = "sirf,prima2-dmac", },
 	{ .compatible = "sirf,marco-dmac", },
 	{},
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 7ebcf9b..5358453 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -896,7 +896,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.nr_max_vchans   = 37,
 };
 
-static struct of_device_id sun6i_dma_match[] = {
+static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-dma", .data = &sun6i_a31_dma_cfg },
 	{ .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg },
 	{ /* sentinel */ }
-- 
2.1.0
