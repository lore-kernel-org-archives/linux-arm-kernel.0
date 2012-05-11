From: hdoyu@nvidia.com (Hiroshi DOYU)
Date: Fri, 11 May 2012 09:56:24 +0300
Subject: [PATCH 1/3] ARM: tegra20: Make MC optional in Kconfig
In-Reply-To: <20120511095012.57f737d1b0d2536e0d367a9b@nvidia.com>
References: <20120511095012.57f737d1b0d2536e0d367a9b@nvidia.com>
Message-ID: <1336719389-28506-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For bare minimal system.

Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig |    2 --
 drivers/memory/Kconfig      |    8 +++++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 16fe065..8b6b181 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -20,8 +20,6 @@ config ARCH_TEGRA_2x_SOC
 	select PL310_ERRATA_727915 if CACHE_L2X0
 	select PL310_ERRATA_769419 if CACHE_L2X0
 	select CPU_FREQ_TABLE if CPU_FREQ
-	select MEMORY
-	select TEGRA20_MC
 	help
 	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
 	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 42e6d66..efc6b36 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -21,8 +21,14 @@ config TI_EMIF
 	  temperature changes
 
 config TEGRA20_MC
-	bool
+	bool "Tegra20 Memory Controller(MC) driver"
+	default y
 	depends on ARCH_TEGRA_2x_SOC
+	help
+	  This driver is for the Memory Controller(MC) module available
+	  in Tegra20 SoCs, mainly for a address translation fault
+	  analysis, especially for IOMMU/GART(Graphics Address
+	  Relocation Table) module.
 
 config TEGRA30_MC
 	bool
-- 
1.7.5.4
