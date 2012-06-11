From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Jun 2012 12:28:29 -0600
Subject: [PATCH] ARM: tegra: enable I2C mux in defconfig
Message-ID: <1339439309-12994-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Add the following, to enable the pinctrl-based I2C mux on Seaboard:
* CONFIG_I2C_MUX
* CONFIG_I2C_MUX_PINCTRL

Some timer options were moved due to unrelated Kconfig changes.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I'll squash this into the existing defconfig update patch.

 arch/arm/configs/tegra_defconfig |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 42fdcf7..4be9c1e 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -1,4 +1,6 @@
 CONFIG_EXPERIMENTAL=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
@@ -28,8 +30,6 @@ CONFIG_MACH_HARMONY=y
 CONFIG_MACH_PAZ00=y
 CONFIG_MACH_TRIMSLICE=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
@@ -100,6 +100,8 @@ CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_TEGRA=y
 CONFIG_SPI=y
 CONFIG_SPI_TEGRA=y
-- 
1.7.0.4
