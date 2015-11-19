From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Thu, 19 Nov 2015 22:33:43 +0100
Subject: [PATCH v2] ARM: sunxi: Re-enable SID driver in multi_v7_defconfig
In-Reply-To: <1447724947-4851-1-git-send-email-public_timo.s@silentcreek.de>
References: <1447724947-4851-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <1447968823-2159-1-git-send-email-public_timo.s@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3d0b16a66c8a ("nvmem: sunxi: Move the SID driver to the nvmem
framework") moved the the sunxi SID driver to a new framework, but left
multi_v7_defconfig with the deprecated config symbol EEPROM_SUNXI_SID
instead of the new symbol NVMEM_SUNXI_SID. Hence, re-enable the driver
in multi_v7_defconfig.

Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
---
Changes in v2:
- Move the extra cleanup work for multi_v7_defconfig to a separate
  patch (to be submitted at a later point to avoid conflicts with
  another patch waiting to be merged)
---
 arch/arm/configs/multi_v7_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index eefcab1..59d3d3a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -188,7 +188,6 @@ CONFIG_ATMEL_SSC=m
 CONFIG_APDS9802ALS=y
 CONFIG_ISL29003=y
 CONFIG_EEPROM_AT24=y
-CONFIG_EEPROM_SUNXI_SID=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_MULTI_LUN=y
@@ -714,6 +713,8 @@ CONFIG_PHY_STIH407_USB=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_SUN9I_USB=y
 CONFIG_PHY_SAMSUNG_USB2=m
+CONFIG_NVMEM=y
+CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.1.4
