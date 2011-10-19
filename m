From: zoss@devai.org (Zoltan Devai)
Date: Wed, 19 Oct 2011 18:01:58 +0200
Subject: [PATCH v2 5/5] ARM: SPMP8000: Add Kconfig and Makefile entries
In-Reply-To: <1319040118-29773-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1319040118-29773-1-git-send-email-zoss@devai.org>
Message-ID: <1319040118-29773-6-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the necessary Kconfig and Makefile entries to build
the SPMP8000 machine

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/Kconfig  |   16 ++++++++++++++++
 arch/arm/Makefile |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9426e26..bfd8317 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -831,6 +831,22 @@ config ARCH_SHARK
 	  Support for the StrongARM based Digital DNARD machine, also known
 	  as "Shark" (<http://www.shark-linux.de/shark.html>).
 
+config ARCH_SPMP8000
+	bool "Sunplus SPMP8000"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_PATCH_PHYS_VIRT
+	select ARM_VIC
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select CPU_ARM926T
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_CHIP
+	select MULTI_IRQ_HANDLER
+	select NO_IOPORT
+	select USE_OF
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
