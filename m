From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 10:11:25 -0600
Subject: [PATCH RESEND 1/5] ARM: tegra: config: enable dmaengine based APB DMA
 driver
Message-ID: <1347639089-2520-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laxman Dewangan <ldewangan@nvidia.com>

Enable config for dmaengine based Tegra APB DMA driver and
disable the legacy APB DMA driver (SYSTEM_DMA).

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I'm looking for Ack's on patches 4 and 5 from the SPI and ASoC maintainers
respectively, so that I can take this series through the Tegra tree for 3.7.

When this series was first posted, there was a bug in the Tegra ASoC PCM
driver which prevented it from working. A fix for this has since been
applied to ASoC's for-3.6 branch and hence should show up in 3.6.

 arch/arm/configs/tegra_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index adcf3c2..2990396 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -29,6 +29,7 @@ CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_TEGRA_PCI=y
 CONFIG_TEGRA_DEBUG_UART_AUTO_ODMDATA=y
+# CONFIG_TEGRA_SYSTEM_DMA is not set
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
@@ -175,6 +176,8 @@ CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_TPS65910=y
 CONFIG_RTC_DRV_EM3027=y
 CONFIG_RTC_DRV_TEGRA=y
+CONFIG_DMADEVICES=y
+CONFIG_TEGRA20_APB_DMA=y
 CONFIG_STAGING=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
-- 
1.7.0.4
