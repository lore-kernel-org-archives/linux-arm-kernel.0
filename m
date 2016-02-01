From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  1 Feb 2016 09:56:05 +0100
Subject: [PATCH 3/3] ARM: realview: enable USB storage in the defconfig
Message-ID: <1454316965-4520-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not uncommon to boot a root filesystem from a USB
pendrive and similar, so enable USB mass storage, backed
by SCSI and SD block devices in the RealView defconfig.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/realview_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index 9f84c508a5f4..9e77dc7b828f 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -48,6 +48,8 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_ROM=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_ARM_CHARLCD=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
@@ -76,6 +78,7 @@ CONFIG_SND_PCM_OSS=y
 # CONFIG_SND_DRIVERS is not set
 CONFIG_SND_ARMAACI=y
 CONFIG_USB=y
+CONFIG_USB_STORAGE=y
 CONFIG_USB_ISP1760=y
 CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
-- 
2.4.3
