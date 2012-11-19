From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:25:47 -0500
Subject: [PATCH 398/493] dma: remove use of __devexit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-398-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Viresh Kumar <viresh.linux@gmail.com> 
Cc: Barry Song <baohua.song@csr.com> 
Cc: linux-arm-kernel at lists.infradead.org 
---
 drivers/dma/dw_dmac.c         | 2 +-
 drivers/dma/edma.c            | 2 +-
 drivers/dma/intel_mid_dma.c   | 2 +-
 drivers/dma/ioat/dma.c        | 2 +-
 drivers/dma/ioat/dma.h        | 2 +-
 drivers/dma/ioat/pci.c        | 4 ++--
 drivers/dma/iop-adma.c        | 2 +-
 drivers/dma/mmp_pdma.c        | 2 +-
 drivers/dma/mmp_tdma.c        | 2 +-
 drivers/dma/mpc512x_dma.c     | 2 +-
 drivers/dma/mv_xor.c          | 2 +-
 drivers/dma/pch_dma.c         | 2 +-
 drivers/dma/pl330.c           | 2 +-
 drivers/dma/ppc4xx/adma.c     | 2 +-
 drivers/dma/sa11x0-dma.c      | 2 +-
 drivers/dma/sh/shdma.c        | 2 +-
 drivers/dma/sirf-dma.c        | 2 +-
 drivers/dma/tegra20-apb-dma.c | 2 +-
 drivers/dma/timb_dma.c        | 2 +-
 19 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 476e9c8..d15e955a 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -1762,7 +1762,7 @@ static int dw_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit dw_remove(struct platform_device *pdev)
+static int dw_remove(struct platform_device *pdev)
 {
 	struct dw_dma		*dw = platform_get_drvdata(pdev);
 	struct dw_dma_chan	*dwc, *_dwc;
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 232b458..f424298 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -585,7 +585,7 @@ err_reg1:
 	return ret;
 }
 
-static int __devexit edma_remove(struct platform_device *pdev)
+static int edma_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct edma_cc *ecc = dev_get_drvdata(dev);
diff --git a/drivers/dma/intel_mid_dma.c b/drivers/dma/intel_mid_dma.c
index bc764af..a0de82e 100644
--- a/drivers/dma/intel_mid_dma.c
+++ b/drivers/dma/intel_mid_dma.c
@@ -1308,7 +1308,7 @@ err_enable_device:
  * Free up all resources and data
  * Call shutdown_dma to complete contoller and chan cleanup
  */
-static void __devexit intel_mid_dma_remove(struct pci_dev *pdev)
+static void intel_mid_dma_remove(struct pci_dev *pdev)
 {
 	struct middma_device *device = pci_get_drvdata(pdev);
 
diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 964ed84..1a68a8b 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -1216,7 +1216,7 @@ int ioat1_dma_probe(struct ioatdma_device *device, int dca)
 	return err;
 }
 
-void __devexit ioat_dma_remove(struct ioatdma_device *device)
+void ioat_dma_remove(struct ioatdma_device *device)
 {
 	struct dma_device *dma = &device->common;
 
diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index b91f543..ee2df01 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -307,7 +307,7 @@ int ioat_probe(struct ioatdma_device *device);
 int ioat_register(struct ioatdma_device *device);
 int ioat1_dma_probe(struct ioatdma_device *dev, int dca);
 int ioat_dma_self_test(struct ioatdma_device *device);
-void __devexit ioat_dma_remove(struct ioatdma_device *device);
+void ioat_dma_remove(struct ioatdma_device *device);
 struct dca_provider *ioat_dca_init(struct pci_dev *pdev,
 					      void __iomem *iobase);
 dma_addr_t ioat_get_current_completion(struct ioat_chan_common *chan);
diff --git a/drivers/dma/ioat/pci.c b/drivers/dma/ioat/pci.c
index b93d46e..27a4416 100644
--- a/drivers/dma/ioat/pci.c
+++ b/drivers/dma/ioat/pci.c
@@ -111,7 +111,7 @@ MODULE_DEVICE_TABLE(pci, ioat_pci_tbl);
 
 static int ioat_pci_probe(struct pci_dev *pdev,
 				    const struct pci_device_id *id);
-static void __devexit ioat_remove(struct pci_dev *pdev);
+static void ioat_remove(struct pci_dev *pdev);
 
 static int ioat_dca_enabled = 1;
 module_param(ioat_dca_enabled, int, 0644);
@@ -195,7 +195,7 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 }
 
-static void __devexit ioat_remove(struct pci_dev *pdev)
+static void ioat_remove(struct pci_dev *pdev)
 {
 	struct ioatdma_device *device = pci_get_drvdata(pdev);
 
diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 62a59fd..7dafb9f 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -1406,7 +1406,7 @@ out:
 }
 #endif
 
-static int __devexit iop_adma_remove(struct platform_device *dev)
+static int iop_adma_remove(struct platform_device *dev)
 {
 	struct iop_adma_device *device = platform_get_drvdata(dev);
 	struct dma_chan *chan, *_chan;
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 13bdf4a..c6d98c0 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -712,7 +712,7 @@ static void dma_do_tasklet(unsigned long data)
 	}
 }
 
-static int __devexit mmp_pdma_remove(struct platform_device *op)
+static int mmp_pdma_remove(struct platform_device *op)
 {
 	struct mmp_pdma_device *pdev = platform_get_drvdata(op);
 
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 323821c..a9f1cd5 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -467,7 +467,7 @@ static void mmp_tdma_issue_pending(struct dma_chan *chan)
 	mmp_tdma_enable_chan(tdmac);
 }
 
-static int __devexit mmp_tdma_remove(struct platform_device *pdev)
+static int mmp_tdma_remove(struct platform_device *pdev)
 {
 	struct mmp_tdma_device *tdev = platform_get_drvdata(pdev);
 
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 2cd024a..2d95673 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -799,7 +799,7 @@ static int mpc_dma_probe(struct platform_device *op)
 	return retval;
 }
 
-static int __devexit mpc_dma_remove(struct platform_device *op)
+static int mpc_dma_remove(struct platform_device *op)
 {
 	struct device *dev = &op->dev;
 	struct mpc_dma *mdma = dev_get_drvdata(dev);
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 3ef4095..a66acb7 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1072,7 +1072,7 @@ out:
 	return err;
 }
 
-static int __devexit mv_xor_remove(struct platform_device *dev)
+static int mv_xor_remove(struct platform_device *dev)
 {
 	struct mv_xor_device *device = platform_get_drvdata(dev);
 	struct dma_chan *chan, *_chan;
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index aed6e0c..d01faeb 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -961,7 +961,7 @@ err_free_mem:
 	return err;
 }
 
-static void __devexit pch_dma_remove(struct pci_dev *pdev)
+static void pch_dma_remove(struct pci_dev *pdev)
 {
 	struct pch_dma *pd = pci_get_drvdata(pdev);
 	struct pch_dma_chan *pd_chan;
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 95555f3..80680ee 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2988,7 +2988,7 @@ probe_err1:
 	return ret;
 }
 
-static int __devexit pl330_remove(struct amba_device *adev)
+static int pl330_remove(struct amba_device *adev)
 {
 	struct dma_pl330_dmac *pdmac = amba_get_drvdata(adev);
 	struct dma_pl330_chan *pch, *_p;
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 89ff7a4..5d3d955 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4592,7 +4592,7 @@ out:
 /**
  * ppc440spe_adma_remove - remove the asynch device
  */
-static int __devexit ppc440spe_adma_remove(struct platform_device *ofdev)
+static int ppc440spe_adma_remove(struct platform_device *ofdev)
 {
 	struct ppc440spe_adma_device *adev = dev_get_drvdata(&ofdev->dev);
 	struct device_node *np = ofdev->dev.of_node;
diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index 2ad628d..461a91a 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -967,7 +967,7 @@ static int sa11x0_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit sa11x0_dma_remove(struct platform_device *pdev)
+static int sa11x0_dma_remove(struct platform_device *pdev)
 {
 	struct sa11x0_dma_dev *d = platform_get_drvdata(pdev);
 	unsigned pch;
diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index 8201bb4..3315e4b 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -880,7 +880,7 @@ ermrdmars:
 	return err;
 }
 
-static int __devexit sh_dmae_remove(struct platform_device *pdev)
+static int sh_dmae_remove(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
 	struct dma_device *dma_dev = &shdev->shdma_dev.dma_dev;
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index c3de6ed..94674a9 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -655,7 +655,7 @@ irq_dispose:
 	return ret;
 }
 
-static int __devexit sirfsoc_dma_remove(struct platform_device *op)
+static int sirfsoc_dma_remove(struct platform_device *op)
 {
 	struct device *dev = &op->dev;
 	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index cb5ebcf..c39e61b 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1360,7 +1360,7 @@ err_pm_disable:
 	return ret;
 }
 
-static int __devexit tegra_dma_remove(struct platform_device *pdev)
+static int tegra_dma_remove(struct platform_device *pdev)
 {
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 	int i;
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 98cf51e..952f823 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -798,7 +798,7 @@ err_release_region:
 
 }
 
-static int __devexit td_remove(struct platform_device *pdev)
+static int td_remove(struct platform_device *pdev)
 {
 	struct timb_dma *td = platform_get_drvdata(pdev);
 	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.8.0
