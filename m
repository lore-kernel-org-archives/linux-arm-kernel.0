From: hjk@hansjkoch.de (Hans J. Koch)
Date: Thu, 22 Dec 2011 22:24:43 +0100
Subject: [PATCH 2/4] arm: Remove TCC subarch from Kconfig/Makefile
In-Reply-To: <20111222211948.GA1201@local>
References: <20111222211948.GA1201@local>
Message-ID: <20111222212442.GC1201@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Telechips subarchitecture is being completely removed.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Harry Sievers <hsievers@csselectronic.com>
Signed-off-by: Hans J. Koch <hjk@hansjkoch.de>
---
 arch/arm/Kconfig  |   10 ----------
 arch/arm/Makefile |    2 --
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 776d76b..1e7dd4b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -868,16 +868,6 @@ config ARCH_SHARK
 	  Support for the StrongARM based Digital DNARD machine, also known
 	  as "Shark" (<http://www.shark-linux.de/shark.html>).
 
-config ARCH_TCC_926
-	bool "Telechips TCC ARM926-based systems"
-	select CLKSRC_MMIO
-	select CPU_ARM926T
-	select HAVE_CLK
-	select CLKDEV_LOOKUP
-	select GENERIC_CLOCKEVENTS
-	help
-	  Support for Telechips TCC ARM926-based systems.
-
 config ARCH_U300
 	bool "ST-Ericsson U300 Series"
 	depends on MMU
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index dfcf3b0..40319d9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -184,7 +184,6 @@ machine-$(CONFIG_ARCH_EXYNOS4)		:= exynos
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
-machine-$(CONFIG_ARCH_TCC8K)		:= tcc8k
 machine-$(CONFIG_ARCH_TEGRA)		:= tegra
 machine-$(CONFIG_ARCH_U300)		:= u300
 machine-$(CONFIG_ARCH_U8500)		:= ux500
@@ -204,7 +203,6 @@ machine-$(CONFIG_ARCH_ZYNQ)		:= zynq
 plat-$(CONFIG_ARCH_MXC)		:= mxc
 plat-$(CONFIG_ARCH_OMAP)	:= omap
 plat-$(CONFIG_ARCH_S3C64XX)	:= samsung
-plat-$(CONFIG_ARCH_TCC_926)	:= tcc
 plat-$(CONFIG_ARCH_ZYNQ)	:= versatile
 plat-$(CONFIG_PLAT_IOP)		:= iop
 plat-$(CONFIG_PLAT_NOMADIK)	:= nomadik
-- 
1.7.6.3
