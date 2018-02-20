From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 20 Feb 2018 13:58:07 +0200
Subject: [PATCH v4 2/7] soc/tegra: Add Tegra194 SoC configuration option
In-Reply-To: <20180220115812.24108-1-mperttunen@nvidia.com>
References: <20180220115812.24108-1-mperttunen@nvidia.com>
Message-ID: <20180220115812.24108-3-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the configuration option to enable support for the Tegra194
system-on-chip, and enable it by default in the arm64 defconfig.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/configs/defconfig |  1 +
 drivers/soc/tegra/Kconfig    | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 78f669a21a9b..5a8f15baa850 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -537,6 +537,7 @@ CONFIG_ROCKCHIP_PM_DOMAINS=y
 CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_ARCH_TEGRA_186_SOC=y
+CONFIG_ARCH_TEGRA_194_SOC=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 89ebe22a3e27..fe4481676da6 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -104,6 +104,16 @@ config ARCH_TEGRA_186_SOC
 	  multi-format support, ISP for image capture processing and BPMP for
 	  power management.
 
+config ARCH_TEGRA_194_SOC
+	bool "NVIDIA Tegra194 SoC"
+	select MAILBOX
+	select TEGRA_BPMP
+	select TEGRA_HSP_MBOX
+	select TEGRA_IVC
+	select SOC_TEGRA_PMC
+	help
+	  Enable support for the NVIDIA Tegra194 SoC.
+
 endif
 endif
 
-- 
2.16.1
