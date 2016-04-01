From: eric@anholt.net (Eric Anholt)
Date: Thu, 31 Mar 2016 17:28:22 -0700
Subject: [PATCH 1/3] ARM: multi_v7_defconfig: Add more BCM2835 support
Message-ID: <1459470504-5007-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The WDT is required for reboot and I2S is used for audio devices on
the P5 header (or BT audio on the Pi3).

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2823490..43a8ce0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -438,6 +438,7 @@ CONFIG_TEGRA_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
 CONFIG_DIGICOLOR_WATCHDOG=y
+CONFIG_BCM2835_WDT=y
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_ATMEL_FLEXCOM=y
@@ -564,6 +565,7 @@ CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_ATMEL_SOC=m
 CONFIG_SND_ATMEL_SOC_WM8904=m
+CONFIG_SND_BCM2835_SOC_I2S=m
 CONFIG_SND_SOC_FSL_SAI=m
 CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
-- 
2.7.0
