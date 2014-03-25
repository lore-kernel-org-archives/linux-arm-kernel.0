From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Mar 2014 11:43:19 -0600
Subject: [PATCH 2/2] ARM: tegra: enable AT24C EEPROM driver
In-Reply-To: <1395769399-8357-1-git-send-email-swarren@wwwdotorg.org>
References: <1395769399-8357-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1395769399-8357-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This is used for the board ID EEPROM on Jetson TK1, as well as likely
a whole slew of other NVIDIA reference boards; we simply haven't added
enabled the EEPROM in the DT files until now.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 131b8d6ff9d3..f0fb8fa79481 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -96,6 +96,7 @@ CONFIG_AD525X_DPOT_I2C=y
 CONFIG_ICS932S401=y
 CONFIG_APDS9802ALS=y
 CONFIG_ISL29003=y
+CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
-- 
1.8.1.5
