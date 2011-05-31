From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 31 May 2011 16:36:48 -0700
Subject: [PATCH v2] gpio: ep93xx: mode driver to drivers/gpio
Message-ID: <201105311636.48619.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO driver should reside in drivers/gpio.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>
Cc: Grant Likely <grant.likely@secretlab.ca>

---

v2: Make the Kconfig symbol a silent option, dependent on ARCH_EP93XX

diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
index 33ee2c8..6b7c41d 100644
--- a/arch/arm/mach-ep93xx/Makefile
+++ b/arch/arm/mach-ep93xx/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-obj-y			:= core.o clock.o dma-m2p.o gpio.o
+obj-y			:= core.o clock.o dma-m2p.o
 obj-m			:=
 obj-n			:=
 obj-			:=
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 342d634..5f87cad 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -86,6 +86,11 @@ config GPIO_IT8761E
 	help
 	  Say yes here to support GPIO functionality of IT8761E super I/O chip.
 
+config GPIO_EP93XX
+	bool
+	depends on ARCH_EP93XX
+	default y
+
 config GPIO_EXYNOS4
 	bool "Samsung Exynos4 GPIO library support"
 	default y if CPU_EXYNOS4210
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4ac7cb3..c8faabe 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_GPIO_ADP5520)	+= adp5520-gpio.o
 obj-$(CONFIG_GPIO_ADP5588)	+= adp5588-gpio.o
 obj-$(CONFIG_GPIO_BASIC_MMIO_CORE)	+= basic_mmio_gpio.o
 obj-$(CONFIG_GPIO_BASIC_MMIO)	+= basic_mmio_gpio.o
+obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_EXYNOS4)	+= gpio-exynos4.o
 obj-$(CONFIG_GPIO_I801)		+= gpio-i801.o
 obj-$(CONFIG_GPIO_PLAT_SAMSUNG)	+= gpio-plat-samsung.o
diff --git a/arch/arm/mach-ep93xx/gpio.c b/drivers/gpio/gpio-ep93xx.c
similarity index 100%
rename from arch/arm/mach-ep93xx/gpio.c
rename to drivers/gpio/gpio-ep93xx.c
