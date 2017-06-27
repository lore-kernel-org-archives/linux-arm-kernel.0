From: s-anna@ti.com (Suman Anna)
Date: Tue, 27 Jun 2017 17:46:09 -0500
Subject: [PATCH 3/4] remoteproc: Drop redundant REMOTEPROC dependency from
 driver Kconfigs
In-Reply-To: <20170627224610.15321-1-s-anna@ti.com>
References: <20170627224610.15321-1-s-anna@ti.com>
Message-ID: <20170627224610.15321-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the remoteproc platform driver Kconfig symbols are defined and
included under an if REMOTEPROC condition, so the dependency on
REMOTEPROC is implicit and they do not need an explicit 'depends
on REMOTEPROC' line. So, clean these up.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index ea344fbf378a..945c1574f896 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -17,7 +17,6 @@ config OMAP_REMOTEPROC
 	depends on HAS_DMA
 	depends on ARCH_OMAP4 || SOC_OMAP5
 	depends on OMAP_IOMMU
-	depends on REMOTEPROC
 	select MAILBOX
 	select OMAP2PLUS_MBOX
 	select RPMSG_VIRTIO
@@ -37,7 +36,6 @@ config OMAP_REMOTEPROC
 config WKUP_M3_RPROC
 	tristate "AMx3xx Wakeup M3 remoteproc support"
 	depends on SOC_AM33XX || SOC_AM43XX
-	depends on REMOTEPROC
 	help
 	  Say y here to support Wakeup M3 remote processor on TI AM33xx
 	  and AM43xx family of SoCs.
@@ -50,7 +48,6 @@ config WKUP_M3_RPROC
 config DA8XX_REMOTEPROC
 	tristate "DA8xx/OMAP-L13x remoteproc support"
 	depends on ARCH_DAVINCI_DA8XX
-	depends on REMOTEPROC
 	depends on DMA_CMA
 	select RPMSG_VIRTIO
 	help
@@ -74,7 +71,6 @@ config KEYSTONE_REMOTEPROC
 	tristate "Keystone Remoteproc support"
 	depends on ARCH_KEYSTONE
 	depends on RESET_CONTROLLER
-	depends on REMOTEPROC
 	select RPMSG_VIRTIO
 	help
 	  Say Y here here to support Keystone remote processors (DSP)
@@ -86,7 +82,6 @@ config KEYSTONE_REMOTEPROC
 config QCOM_ADSP_PIL
 	tristate "Qualcomm ADSP Peripheral Image Loader"
 	depends on OF && ARCH_QCOM
-	depends on REMOTEPROC
 	depends on QCOM_SMEM
 	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
 	select MFD_SYSCON
@@ -104,7 +99,6 @@ config QCOM_Q6V5_PIL
 	tristate "Qualcomm Hexagon V5 Peripherial Image Loader"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
-	depends on REMOTEPROC
 	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
 	select MFD_SYSCON
 	select QCOM_RPROC_COMMON
@@ -118,7 +112,6 @@ config QCOM_WCNSS_PIL
 	depends on OF && ARCH_QCOM
 	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
 	depends on QCOM_SMEM
-	depends on REMOTEPROC
 	select QCOM_MDT_LOADER
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
@@ -129,7 +122,6 @@ config QCOM_WCNSS_PIL
 config ST_REMOTEPROC
 	tristate "ST remoteproc support"
 	depends on ARCH_STI
-	depends on REMOTEPROC
 	select MAILBOX
 	select STI_MBOX
 	select RPMSG_VIRTIO
@@ -140,7 +132,6 @@ config ST_REMOTEPROC
 
 config ST_SLIM_REMOTEPROC
 	tristate
-	depends on REMOTEPROC
 
 endif # REMOTEPROC
 
-- 
2.13.1
