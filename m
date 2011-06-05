From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  6 Jun 2011 00:07:54 +0800
Subject: [PATCH v4 1/2] gpio/mxc: Move Freescale MXC gpio driver to
	drivers/gpio
In-Reply-To: <1307290075-7062-1-git-send-email-shawn.guo@linaro.org>
References: <1307290075-7062-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1307290075-7062-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO drivers are getting moved to drivers/gpio for cleanup and
consolidation.  This patch moves the plat-mxc driver.  Follow up
patches will clean it up and make it a fine upstanding gpio driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/plat-mxc/Makefile                         |    2 +-
 drivers/gpio/Kconfig                               |    4 ++++
 drivers/gpio/Makefile                              |    1 +
 .../arm/plat-mxc/gpio.c => drivers/gpio/gpio-mxc.c |    0
 4 files changed, 6 insertions(+), 1 deletions(-)
 rename arch/arm/plat-mxc/gpio.c => drivers/gpio/gpio-mxc.c (100%)

diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index a138787..d53c35f 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := clock.o gpio.o time.o devices.o cpu.o system.o irq-common.o
+obj-y := clock.o time.o devices.o cpu.o system.o irq-common.o
 
 # MX51 uses the TZIC interrupt controller, older platforms use AVIC
 obj-$(CONFIG_MXC_TZIC) += tzic.o
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 18c0b31..5f00b41 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -93,6 +93,10 @@ config GPIO_EXYNOS4
 	help
 	  Say yes here to support Samsung Exynos4 series SoCs GPIO library
 
+config GPIO_MXC
+	def_bool y
+	depends on ARCH_MXC
+
 config GPIO_PLAT_SAMSUNG
 	bool "Samsung SoCs GPIO library support"
 	default y
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4ac7cb3..2fb0d00 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_GPIO_BASIC_MMIO_CORE)	+= basic_mmio_gpio.o
 obj-$(CONFIG_GPIO_BASIC_MMIO)	+= basic_mmio_gpio.o
 obj-$(CONFIG_GPIO_EXYNOS4)	+= gpio-exynos4.o
 obj-$(CONFIG_GPIO_I801)		+= gpio-i801.o
+obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
 obj-$(CONFIG_GPIO_PLAT_SAMSUNG)	+= gpio-plat-samsung.o
 obj-$(CONFIG_GPIO_S5PC100)	+= gpio-s5pc100.o
 obj-$(CONFIG_GPIO_S5PV210)	+= gpio-s5pv210.o
diff --git a/arch/arm/plat-mxc/gpio.c b/drivers/gpio/gpio-mxc.c
similarity index 100%
rename from arch/arm/plat-mxc/gpio.c
rename to drivers/gpio/gpio-mxc.c
-- 
1.7.4.1
