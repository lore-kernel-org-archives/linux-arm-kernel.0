From: markus.mayer@linaro.org (Markus Mayer)
Date: Wed, 28 Aug 2013 15:16:12 -0700
Subject: [PATCH v5 2/3] ARM: bcm281xx: Enable GPIO driver
In-Reply-To: <1377728173-30711-1-git-send-email-markus.mayer@linaro.org>
References: <1377728173-30711-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <1377728173-30711-3-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Kconfig and Makefile glue to compile the GPIO
driver for bcm281xx when CONFIG_GPIO_BCM=y.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/mach-bcm/Kconfig |    2 +-
 drivers/gpio/Kconfig      |    5 +++++
 drivers/gpio/Makefile     |    1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index f112895..5819126 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -9,7 +9,7 @@ config ARCH_BCM
 	select CLKSRC_OF
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_TIME
-	select GPIO_BCM
+	select GPIO_BCM_KONA
 	select SPARSE_IRQ
 	select TICK_ONESHOT
 	help
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b2450ba..b68e9b5 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -714,6 +714,11 @@ config GPIO_MSIC
 	  Enable support for GPIO on intel MSIC controllers found in
 	  intel MID devices
 
+config GPIO_BCM_KONA
+	bool "Broadcom Kona GPIO"
+	help
+	  Turn on GPIO support for Broadcom "Kona" chips.
+
 comment "USB GPIO expanders:"
 
 config GPIO_VIPERBOARD
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index ef3e983..fcd0751 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_GPIO_ADP5520)	+= gpio-adp5520.o
 obj-$(CONFIG_GPIO_ADP5588)	+= gpio-adp5588.o
 obj-$(CONFIG_GPIO_AMD8111)	+= gpio-amd8111.o
 obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
+obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
 obj-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
 obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
-- 
1.7.9.5
