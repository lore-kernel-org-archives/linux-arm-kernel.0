From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 19 Jul 2011 13:50:28 +0800
Subject: [PATCH] ARM: mmp: share spi driver for ARCH-MMP
In-Reply-To: <2011071902>
References: <2011071902>
Message-ID: <1311054628-15807-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jialing Fu <jlfu@marvell.com>

Share spi driver to ARCH-MMP.

Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/spi/Kconfig            |    4 ++--
 include/linux/spi/pxa2xx_spi.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index de35c3a..79e8093 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -300,8 +300,8 @@ config SPI_PPC4xx
 
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
-	depends on (ARCH_PXA || (X86_32 && PCI)) && EXPERIMENTAL
-	select PXA_SSP if ARCH_PXA
+	depends on (ARCH_PXA || ARCH_MMP || (X86_32 && PCI)) && EXPERIMENTAL
+	select PXA_SSP if ARCH_PXA || ARCH_MMP
 	help
 	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
 	  controller. The driver can be configured to use any SSP port and
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index d3e1075..c73d144 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -43,7 +43,7 @@ struct pxa2xx_spi_chip {
 	void (*cs_control)(u32 command);
 };
 
-#ifdef CONFIG_ARCH_PXA
+#if defined(CONFIG_ARCH_PXA) || defined(CONFIG_ARCH_MMP)
 
 #include <linux/clk.h>
 #include <mach/dma.h>
-- 
1.5.6.5
