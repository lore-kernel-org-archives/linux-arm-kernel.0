From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 14 Mar 2014 10:30:28 -0700
Subject: [PATCH] ARM: davinci: fix DT booting with default defconfig
Message-ID: <1394818228-1846-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Davinci boards tend to have older booloaders without DTB support.
Enable appended DTB support by default to allow DT booting on older
platforms.  While there, also enable /proc/device-tree support for
easy verification of DT boot.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
Sekhar, this applies on top of your latest defconfig cleanup queued
for v3.15 and validated with DT and legacy boot on DA850 EVM.

 arch/arm/configs/davinci_all_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index fff4eb6f62c2..2df72ffb09a2 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -40,6 +40,8 @@ CONFIG_LEDS=y
 CONFIG_USE_OF=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_AUTO_ZRELADDR=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
@@ -70,6 +72,7 @@ CONFIG_MTD_CFI_AMDSTD=m
 CONFIG_MTD_PHYSMAP=m
 CONFIG_MTD_NAND=m
 CONFIG_MTD_NAND_DAVINCI=m
+CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
-- 
1.8.3
