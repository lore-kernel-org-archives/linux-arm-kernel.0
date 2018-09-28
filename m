From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Fri, 28 Sep 2018 11:43:22 +0300
Subject: [PATCH v2 3/5] soc/fsl/qbman: Add 64 bit DMA addressing requirement
 to QBMan
In-Reply-To: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1538124204-31406-4-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roy Pledge <roy.pledge@nxp.com>

The QBMan block is memory mapped on SoCs above a 32 bit (4 Gigabyte)
boundary so enabling 64 bit DMA addressing is needed for QBMan to
be usuable.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/Kconfig b/drivers/soc/fsl/qbman/Kconfig
index d570cb5fd381..b0943e541796 100644
--- a/drivers/soc/fsl/qbman/Kconfig
+++ b/drivers/soc/fsl/qbman/Kconfig
@@ -1,6 +1,6 @@
 menuconfig FSL_DPAA
 	bool "QorIQ DPAA1 framework support"
-	depends on (FSL_SOC_BOOKE || ARCH_LAYERSCAPE)
+	depends on ((FSL_SOC_BOOKE || ARCH_LAYERSCAPE) && ARCH_DMA_ADDR_T_64BIT)
 	select GENERIC_ALLOCATOR
 	help
 	  The Freescale Data Path Acceleration Architecture (DPAA) is a set of
-- 
2.1.0
