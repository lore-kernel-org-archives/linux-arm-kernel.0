From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Apr 2014 15:10:27 -0600
Subject: [PATCH] ARM: multi_v7: enable AT24C EEPROM driver
Message-ID: <1397596227-23174-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This is used for the board ID EEPROM on Jetson TK1, as well as likely
a whole slew of other NVIDIA reference boards; we simply haven't added
enabled the EEPROM in the DT files until now.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I assume that updates to this file should go through arm-soc to minimize
conflicts.

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47a2f7c..a692b7ae3bd1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -112,6 +112,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_ICS932S401=y
 CONFIG_APDS9802ALS=y
 CONFIG_ISL29003=y
+CONFIG_EEPROM_AT24=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_MULTI_LUN=y
-- 
1.8.1.5
