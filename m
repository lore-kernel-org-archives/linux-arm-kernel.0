From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 14 Dec 2011 17:03:14 +0200
Subject: [PATCH v7 02/14] arm/tegra: cleanup tegra20 support
In-Reply-To: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
References: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1323875032-18221-3-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* add a dependency to ARCH_TEGRA_2x_SOC in Kconfig to all tegra20 based boards
  and TEGRA_PCI
* make powergating dependent on ARCH_TEGRA_2x_SOC
* remove dependency on ARCH_TEGRA_2x_SOC for clock.c

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig  |    8 ++++++++
 arch/arm/mach-tegra/Makefile |    3 +--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 91aff7c..2b1d49b 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -21,18 +21,21 @@ endchoice
 
 config TEGRA_PCI
 	bool "PCI Express support"
+	depends on ARCH_TEGRA_2x_SOC
 	select PCI
 
 comment "Tegra board type"
 
 config MACH_HARMONY
        bool "Harmony board"
+       depends on ARCH_TEGRA_2x_SOC
        select MACH_HAS_SND_SOC_TEGRA_WM8903 if SND_SOC
        help
          Support for nVidia Harmony development platform
 
 config MACH_KAEN
        bool "Kaen board"
+       depends on ARCH_TEGRA_2x_SOC
        select MACH_SEABOARD
        select MACH_HAS_SND_SOC_TEGRA_WM8903 if SND_SOC
        help
@@ -40,11 +43,13 @@ config MACH_KAEN
 
 config MACH_PAZ00
        bool "Paz00 board"
+       depends on ARCH_TEGRA_2x_SOC
        help
          Support for the Toshiba AC100/Dynabook AZ netbook
 
 config MACH_SEABOARD
        bool "Seaboard board"
+       depends on ARCH_TEGRA_2x_SOC
        select MACH_HAS_SND_SOC_TEGRA_WM8903 if SND_SOC
        help
          Support for nVidia Seaboard development platform. It will
@@ -59,18 +64,21 @@ config MACH_TEGRA_DT
 
 config MACH_TRIMSLICE
        bool "TrimSlice board"
+       depends on ARCH_TEGRA_2x_SOC
        select TEGRA_PCI
        help
          Support for CompuLab TrimSlice platform
 
 config MACH_WARIO
        bool "Wario board"
+       depends on ARCH_TEGRA_2x_SOC
        select MACH_SEABOARD
        help
          Support for the Wario version of Seaboard
 
 config MACH_VENTANA
        bool "Ventana board"
+       depends on ARCH_TEGRA_2x_SOC
        select MACH_TEGRA_DT
        help
          Support for the nVidia Ventana development platform
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index c9ec38e..26ff456 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -5,9 +5,8 @@ obj-y                                   += irq.o
 obj-y                                   += clock.o
 obj-y                                   += timer.o
 obj-y                                   += pinmux.o
-obj-y                                   += powergate.o
 obj-y					+= fuse.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clock.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= powergate.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pinmux-t2-tables.o
-- 
1.7.7.rc0.72.g4b5ea.dirty
