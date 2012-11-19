From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:20:04 -0500
Subject: [PATCH 055/493] dma: remove use of __devexit_p
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-55-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Viresh Kumar <viresh.linux@gmail.com> 
Cc: Barry Song <baohua.song@csr.com> 
Cc: linux-arm-kernel at lists.infradead.org 
---
 drivers/dma/dw_dmac.c         | 2 +-
 drivers/dma/edma.c            | 2 +-
 drivers/dma/intel_mid_dma.c   | 2 +-
 drivers/dma/ioat/pci.c        | 2 +-
 drivers/dma/iop-adma.c        | 2 +-
 drivers/dma/mmp_pdma.c        | 2 +-
 drivers/dma/mmp_tdma.c        | 2 +-
 drivers/dma/mpc512x_dma.c     | 2 +-
 drivers/dma/mv_xor.c          | 2 +-
 drivers/dma/pch_dma.c         | 2 +-
 drivers/dma/ppc4xx/adma.c     | 2 +-
 drivers/dma/sa11x0-dma.c      | 2 +-
 drivers/dma/sh/shdma.c        | 2 +-
 drivers/dma/sirf-dma.c        | 2 +-
 drivers/dma/tegra20-apb-dma.c | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 2c8096d..67f6358 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -1829,7 +1829,7 @@ MODULE_DEVICE_TABLE(of, dw_dma_id_table);
 #endif
 
 static struct platform_driver dw_driver = {
-	.remove		= __devexit_p(dw_remove),
+	.remove		= dw_remove,
 	.shutdown	= dw_shutdown,
 	.driver = {
 		.name	= "dw_dmac",
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 05aea3c..5e5cce4 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -598,7 +598,7 @@ static int __devexit edma_remove(struct platform_device *pdev)
 
 static struct platform_driver edma_driver = {
 	.probe		= edma_probe,
-	.remove		= __devexit_p(edma_remove),
+	.remove		= edma_remove,
 	.driver = {
 		.name = "edma-dma-engine",
 		.owner = THIS_MODULE,
diff --git a/drivers/dma/intel_mid_dma.c b/drivers/dma/intel_mid_dma.c
index 02b21d7..dffdeff 100644
--- a/drivers/dma/intel_mid_dma.c
+++ b/drivers/dma/intel_mid_dma.c
@@ -1432,7 +1432,7 @@ static struct pci_driver intel_mid_dma_pci_driver = {
 	.name		=	"Intel MID DMA",
 	.id_table	=	intel_mid_dma_ids,
 	.probe		=	intel_mid_dma_probe,
-	.remove		=	__devexit_p(intel_mid_dma_remove),
+	.remove		=	intel_mid_dma_remove,
 #ifdef CONFIG_PM
 	.driver = {
 		.pm = &intel_mid_dma_pm,
diff --git a/drivers/dma/ioat/pci.c b/drivers/dma/ioat/pci.c
index c057306..bfa9a35 100644
--- a/drivers/dma/ioat/pci.c
+++ b/drivers/dma/ioat/pci.c
@@ -125,7 +125,7 @@ static struct pci_driver ioat_pci_driver = {
 	.name		= DRV_NAME,
 	.id_table	= ioat_pci_tbl,
 	.probe		= ioat_pci_probe,
-	.remove		= __devexit_p(ioat_remove),
+	.remove		= ioat_remove,
 };
 
 static struct ioatdma_device *
diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index e11d930..80d986a 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -1710,7 +1710,7 @@ static void iop_chan_start_null_xor(struct iop_adma_chan *iop_chan)
 
 static struct platform_driver iop_adma_driver = {
 	.probe		= iop_adma_probe,
-	.remove		= __devexit_p(iop_adma_remove),
+	.remove		= iop_adma_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "iop-adma",
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 14da1f4..4777986 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -865,7 +865,7 @@ static struct platform_driver mmp_pdma_driver = {
 	},
 	.id_table	= mmp_pdma_id_table,
 	.probe		= mmp_pdma_probe,
-	.remove		= __devexit_p(mmp_pdma_remove),
+	.remove		= mmp_pdma_remove,
 };
 
 module_platform_driver(mmp_pdma_driver);
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index f3e8d71..7d7fc6b 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -609,7 +609,7 @@ static struct platform_driver mmp_tdma_driver = {
 	},
 	.id_table	= mmp_tdma_id_table,
 	.probe		= mmp_tdma_probe,
-	.remove		= __devexit_p(mmp_tdma_remove),
+	.remove		= mmp_tdma_remove,
 };
 
 module_platform_driver(mmp_tdma_driver);
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 2ab0a3d..4b8754b 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -818,7 +818,7 @@ static struct of_device_id mpc_dma_match[] = {
 
 static struct platform_driver mpc_dma_driver = {
 	.probe		= mpc_dma_probe,
-	.remove		= __devexit_p(mpc_dma_remove),
+	.remove		= mpc_dma_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index f9d09ae..119ed50 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1254,7 +1254,7 @@ mv_xor_conf_mbus_windows(struct mv_xor_shared_private *msp,
 
 static struct platform_driver mv_xor_driver = {
 	.probe		= mv_xor_probe,
-	.remove		= __devexit_p(mv_xor_remove),
+	.remove		= mv_xor_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= MV_XOR_NAME,
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index b405916..ee3d567 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -1022,7 +1022,7 @@ static struct pci_driver pch_dma_driver = {
 	.name		= DRV_NAME,
 	.id_table	= pch_dma_id_table,
 	.probe		= pch_dma_probe,
-	.remove		= __devexit_p(pch_dma_remove),
+	.remove		= pch_dma_remove,
 #ifdef CONFIG_PM
 	.suspend	= pch_dma_suspend,
 	.resume		= pch_dma_resume,
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index f72348d..5c6717c 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4914,7 +4914,7 @@ MODULE_DEVICE_TABLE(of, ppc440spe_adma_of_match);
 
 static struct platform_driver ppc440spe_adma_driver = {
 	.probe = ppc440spe_adma_probe,
-	.remove = __devexit_p(ppc440spe_adma_remove),
+	.remove = ppc440spe_adma_remove,
 	.driver = {
 		.name = "PPC440SP(E)-ADMA",
 		.owner = THIS_MODULE,
diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index b893159..1255d9b 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -1072,7 +1072,7 @@ static struct platform_driver sa11x0_dma_driver = {
 		.pm	= &sa11x0_dma_pm_ops,
 	},
 	.probe		= sa11x0_dma_probe,
-	.remove		= __devexit_p(sa11x0_dma_remove),
+	.remove		= sa11x0_dma_remove,
 };
 
 bool sa11x0_dma_filter_fn(struct dma_chan *chan, void *param)
diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index f41bcc5..7dcf4e0 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -926,7 +926,7 @@ static struct platform_driver sh_dmae_driver = {
 		.pm	= &sh_dmae_pm,
 		.name	= SH_DMAE_DRV_NAME,
 	},
-	.remove		= __devexit_p(sh_dmae_remove),
+	.remove		= sh_dmae_remove,
 	.shutdown	= sh_dmae_shutdown,
 };
 
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index d451caa..62d42c9 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -673,7 +673,7 @@ static struct of_device_id sirfsoc_dma_match[] = {
 
 static struct platform_driver sirfsoc_dma_driver = {
 	.probe		= sirfsoc_dma_probe,
-	.remove		= __devexit_p(sirfsoc_dma_remove),
+	.remove		= sirfsoc_dma_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 528c62d..655c434 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1418,7 +1418,7 @@ static struct platform_driver tegra_dmac_driver = {
 		.of_match_table = of_match_ptr(tegra_dma_of_match),
 	},
 	.probe		= tegra_dma_probe,
-	.remove		= __devexit_p(tegra_dma_remove),
+	.remove		= tegra_dma_remove,
 };
 
 module_platform_driver(tegra_dmac_driver);
-- 
1.8.0
