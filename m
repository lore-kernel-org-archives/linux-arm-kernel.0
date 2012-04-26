From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Apr 2012 11:52:51 -0600
Subject: [PATCH 4/4] ARM: tegra: update defconfig
In-Reply-To: <1335462771-21791-1-git-send-email-swarren@wwwdotorg.org>
References: <1335462771-21791-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1335462771-21791-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Enable support for sensors on Seaboard:
* INPUT_MPU3050
* BATTERY_SBS

and options they depend on:
* INPUT_MISC=y
* POWER_SUPPLY=y

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
(This will be squashed into the existing defconfig update patch in Tegra's
for-next branch)
---
 arch/arm/configs/tegra_defconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 99c3e66..310fe81 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -92,6 +92,8 @@ CONFIG_USB_NET_SMSC75XX=y
 CONFIG_USB_NET_SMSC95XX=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_MPU3050=y
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
@@ -104,6 +106,8 @@ CONFIG_I2C=y
 CONFIG_I2C_TEGRA=y
 CONFIG_SPI=y
 CONFIG_SPI_TEGRA=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_BATTERY_SBS=y
 CONFIG_SENSORS_LM90=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_REGULATOR=y
-- 
1.7.0.4
