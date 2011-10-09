From: zoss@devai.org (Zoltan Devai)
Date: Sun,  9 Oct 2011 18:36:12 +0200
Subject: [PATCH 9/9] ARM: SPMP8000: Add Kconfig and Makefile entries to build
	the machine
In-Reply-To: <1318178172-7965-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
Message-ID: <1318178172-7965-10-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/Kconfig  |   16 ++++++++++++++++
 arch/arm/Makefile |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9426e26..f34f10d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -831,6 +831,22 @@ config ARCH_SHARK
 	  Support for the StrongARM based Digital DNARD machine, also known
 	  as "Shark" (<http://www.shark-linux.de/shark.html>).
 
+config ARCH_SPMP8000
+	bool "Sunplus SPMP8000"
+	select CPU_ARM926T
+	select ARM_VIC
+	select GENERIC_IRQ_CHIP
+	select MULTI_IRQ_HANDLER
+	select CLKSRC_MMIO
+	select GENERIC_CLOCKEVENTS
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select USE_OF
+	select CLKDEV_LOOKUP
+	select HAVE_PWM
+	select ARCH_HAS_CPUFREQ
+	help
+	  Support for Sunplus SPMP8000A/8010A/8016A SoC.
+
 config ARCH_TCC_926
 	bool "Telechips TCC ARM926-based systems"
 	select CLKSRC_MMIO
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e0ac6eb..f837a3b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -180,6 +180,7 @@ machine-$(CONFIG_ARCH_EXYNOS4)		:= exynos4
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
+machine-$(CONFIG_ARCH_SPMP8000)		:= spmp8000
 machine-$(CONFIG_ARCH_TCC8K)		:= tcc8k
 machine-$(CONFIG_ARCH_TEGRA)		:= tegra
 machine-$(CONFIG_ARCH_U300)		:= u300
-- 
1.7.4.1
