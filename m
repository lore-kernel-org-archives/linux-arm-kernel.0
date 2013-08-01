From: matt.porter@linaro.org (Matt Porter)
Date: Thu,  1 Aug 2013 13:12:11 -0400
Subject: [PATCH] ARM: configs: disable DEBUG_LL in bcm_defconfig
Message-ID: <1375377131-27445-1-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DEBUG_LL is not supported yet on bcm281xx and causes a temporary
hang due to timeout at boot.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/configs/bcm_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 65edf6d..27a1b5f 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -112,7 +112,6 @@ CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=110
 CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_FTRACE is not set
-CONFIG_DEBUG_LL=y
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRC_ITU_T=y
-- 
1.7.9.5
