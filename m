From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Jul 2013 10:53:28 -0700
Subject: [PATCH v5 14/16] ARM: tegra: Update default configuration (PCIe)
In-Reply-To: <1374774810-18459-1-git-send-email-thierry.reding@gmail.com>
References: <1374774810-18459-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1374774810-18459-15-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Enable PCI and MSI support as well as the new Tegra PCIe controller
driver.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v5:
- enable PCI Express support (CONFIG_PCIEPORTBUS)

 arch/arm/configs/tegra_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 36ad70c..1586dda 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -27,8 +27,11 @@ CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
-CONFIG_TEGRA_PCI=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_TEGRA=y
+CONFIG_PCIEPORTBUS=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-- 
1.8.1.5
