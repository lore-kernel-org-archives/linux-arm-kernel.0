From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 18 May 2012 15:16:29 +0530
Subject: [PATCH 3/6] ARM: Exynos4: Enable platform support for SPI controllers
In-Reply-To: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
References: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1337334392-6441-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the platform bits which are required to support SPI controllers.
The OF based partition parsing is also enabled to allow usage of SPI
nor flash on smdkv310 board.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/Kconfig             |    1 +
 arch/arm/mach-exynos/include/mach/irqs.h |    4 ++++
 arch/arm/mach-exynos/mach-exynos4-dt.c   |    6 ++++++
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 07f6346..9d07e3d 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -393,6 +393,7 @@ config MACH_EXYNOS4_DT
 	select USE_OF
 	select ARM_AMBA
 	select HAVE_SAMSUNG_KEYPAD if INPUT_KEYBOARD
+	select MTD_OF_PARTS if (MTD && OF && SPI_S3C64XX)
 	help
 	  Machine support for Samsung Exynos4 machine with device tree enabled.
 	  Select this if a fdt blob is available for the Exynos4 SoC based board.
diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index 561553a..195773b 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -195,6 +195,10 @@
 #define IRQ_IIC6			EXYNOS4_IRQ_IIC6
 #define IRQ_IIC7			EXYNOS4_IRQ_IIC7
 
+#define IRQ_SPI0			EXYNOS4_IRQ_SPI0
+#define IRQ_SPI1			EXYNOS4_IRQ_SPI1
+#define IRQ_SPI2			EXYNOS4_IRQ_SPI2
+
 #define IRQ_USB_HOST			EXYNOS4_IRQ_USB_HOST
 
 #define IRQ_HSMMC0			EXYNOS4_IRQ_HSMMC0
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 8245f1c..f63f0bb 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -55,6 +55,12 @@ static const struct of_dev_auxdata exynos4210_auxdata_lookup[] __initconst = {
 				"exynos4-sdhci.3", NULL),
 	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(0),
 				"s3c2440-i2c.0", NULL),
+	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS4_PA_SPI0,
+				"exynos4210-spi.0", NULL),
+	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS4_PA_SPI1,
+				"exynos4210-spi.1", NULL),
+	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS4_PA_SPI2,
+				"exynos4210-spi.2", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA0, "dma-pl330.0", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA1, "dma-pl330.1", NULL),
 	{},
-- 
1.6.6.rc2
