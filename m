From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 25 Oct 2013 09:11:14 +0200
Subject: [PATCH 2/2] ARM: s3c64xx: cpuidle: move driver to drivers/cpuidle
In-Reply-To: <1382685074-16502-1-git-send-email-daniel.lezcano@linaro.org>
References: <1382685074-16502-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1382685074-16502-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no more dependency with the arch dependant code, thanks to the platform
driver conversion.

Move the driver to the drivers/cpuidle like the other drivers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-s3c64xx/Makefile                     |    1 -
 drivers/cpuidle/Kconfig.arm                        |    7 +++++++
 drivers/cpuidle/Makefile                           |    1 +
 .../cpuidle.c => drivers/cpuidle/cpuidle-s3c64xx.c |    0
 4 files changed, 8 insertions(+), 1 deletion(-)
 rename arch/arm/mach-s3c64xx/cpuidle.c => drivers/cpuidle/cpuidle-s3c64xx.c (100%)

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 31d0c91..e7a3ee7 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -22,7 +22,6 @@ obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
 # PM
 
 obj-$(CONFIG_PM)		+= pm.o irq-pm.o sleep.o
-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
 # DMA support
 
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index f23bd75..5b2f84d 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -44,3 +44,10 @@ config ARM_AT91_CPUIDLE
 	depends on ARCH_AT91
 	help
 	  Select this to enable cpuidle for AT91 processors
+
+config ARM_S3C64XX_CPUIDLE
+	bool "Cpu Idle Driver for the s3c64xx processors"
+	default y
+	depends on ARCH_S3C64XX
+	help
+	  Select this to enable cpuidle for s3c64xx processors
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 527be28..2768020 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
+obj-$(CONFIG_ARM_S3C64XX_CPUIDLE)	+= cpuidle-s3c64xx.o
diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/drivers/cpuidle/cpuidle-s3c64xx.c
similarity index 100%
rename from arch/arm/mach-s3c64xx/cpuidle.c
rename to drivers/cpuidle/cpuidle-s3c64xx.c
-- 
1.7.9.5
