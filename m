From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu,  3 Dec 2015 01:12:33 -0500
Subject: [PATCH V8 1/5] dma: qcom_bam_dma: move to qcom directory
In-Reply-To: <1449123159-28261-1-git-send-email-okaya@codeaurora.org>
References: <1449123159-28261-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1449123159-28261-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Creating a QCOM directory for all QCOM DMA source files.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Andy Gtoss <agross@codeaurora.org>
---
 drivers/dma/Kconfig                            | 11 ++---------
 drivers/dma/Makefile                           |  2 +-
 drivers/dma/qcom/Kconfig                       |  8 ++++++++
 drivers/dma/qcom/Makefile                      |  1 +
 drivers/dma/{qcom_bam_dma.c => qcom/bam_dma.c} |  4 ++--
 5 files changed, 14 insertions(+), 12 deletions(-)
 create mode 100644 drivers/dma/qcom/Kconfig
 create mode 100644 drivers/dma/qcom/Makefile
 rename drivers/dma/{qcom_bam_dma.c => qcom/bam_dma.c} (99%)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index b458475..47b1b98 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -408,15 +408,6 @@ config PXA_DMA
 	  16 to 32 channels for peripheral to memory or memory to memory
 	  transfers.
 
-config QCOM_BAM_DMA
-	tristate "QCOM BAM DMA support"
-	depends on ARCH_QCOM || (COMPILE_TEST && OF && ARM)
-	select DMA_ENGINE
-	select DMA_VIRTUAL_CHANNELS
-	---help---
-	  Enable support for the QCOM BAM DMA controller.  This controller
-	  provides DMA capabilities for a variety of on-chip devices.
-
 config SIRF_DMA
 	tristate "CSR SiRFprimaII/SiRFmarco DMA support"
 	depends on ARCH_SIRF
@@ -527,6 +518,8 @@ config ZX_DMA
 # driver files
 source "drivers/dma/bestcomm/Kconfig"
 
+source "drivers/dma/qcom/Kconfig"
+
 source "drivers/dma/dw/Kconfig"
 
 source "drivers/dma/hsu/Kconfig"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 7711a71..8dba90d 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_PCH_DMA) += pch_dma.o
 obj-$(CONFIG_PL330_DMA) += pl330.o
 obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
 obj-$(CONFIG_PXA_DMA) += pxa_dma.o
-obj-$(CONFIG_QCOM_BAM_DMA) += qcom_bam_dma.o
 obj-$(CONFIG_RENESAS_DMA) += sh/
 obj-$(CONFIG_SIRF_DMA) += sirf-dma.o
 obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
@@ -66,4 +65,5 @@ obj-$(CONFIG_TI_EDMA) += edma.o
 obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ZX_DMA) += zx296702_dma.o
 
+obj-y += qcom/
 obj-y += xilinx/
diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
new file mode 100644
index 0000000..f17c272
--- /dev/null
+++ b/drivers/dma/qcom/Kconfig
@@ -0,0 +1,8 @@
+config QCOM_BAM_DMA
+	tristate "QCOM BAM DMA support"
+	depends on ARCH_QCOM || (COMPILE_TEST && OF && ARM)
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	---help---
+	  Enable support for the QCOM BAM DMA controller.  This controller
+	  provides DMA capabilities for a variety of on-chip devices.
diff --git a/drivers/dma/qcom/Makefile b/drivers/dma/qcom/Makefile
new file mode 100644
index 0000000..f612ae3
--- /dev/null
+++ b/drivers/dma/qcom/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_QCOM_BAM_DMA) += bam_dma.o
diff --git a/drivers/dma/qcom_bam_dma.c b/drivers/dma/qcom/bam_dma.c
similarity index 99%
rename from drivers/dma/qcom_bam_dma.c
rename to drivers/dma/qcom/bam_dma.c
index 5a250cd..b6f053d 100644
--- a/drivers/dma/qcom_bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -49,8 +49,8 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 
-#include "dmaengine.h"
-#include "virt-dma.h"
+#include "../dmaengine.h"
+#include "../virt-dma.h"
 
 struct bam_desc_hw {
 	u32 addr;		/* Buffer physical address */
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
