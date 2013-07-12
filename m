From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 12 Jul 2013 19:38:26 +0530
Subject: [PATCH] ARM: davinci: defconfig: enable EDMA driver
Message-ID: <1373638106-18706-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable EDMA dmaengine driver by default in DaVinci
defconfig files as it is required for DMA support
on MMC/SD, SPI etc.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/da8xx_omapl_defconfig |    2 ++
 arch/arm/configs/davinci_all_defconfig |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/configs/da8xx_omapl_defconfig b/arch/arm/configs/da8xx_omapl_defconfig
index 7c86813..1571bea 100644
--- a/arch/arm/configs/da8xx_omapl_defconfig
+++ b/arch/arm/configs/da8xx_omapl_defconfig
@@ -102,6 +102,8 @@ CONFIG_SND_SOC=m
 CONFIG_SND_DAVINCI_SOC=m
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_DMADEVICES=y
+CONFIG_TI_EDMA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_XFS_FS=m
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index c86fd75..ab2f737 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -162,6 +162,8 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=m
 CONFIG_LEDS_TRIGGER_HEARTBEAT=m
 CONFIG_RTC_CLASS=y
+CONFIG_DMADEVICES=y
+CONFIG_TI_EDMA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_XFS_FS=m
-- 
1.7.10.1
