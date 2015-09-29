From: jc@eclis.ch (jc at eclis.ch)
Date: Wed, 30 Sep 2015 00:32:48 +0200
Subject: [PATCH 1/1] Disable CONFIG_UACCESS_WITH_MEMCPY in Atmel config.
Message-ID: <1443565968-7012-1-git-send-email-jc@eclis.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christian de Rivaz <jc@eclis.ch>

According to Russell King:
In any case, unless you have a Marvell platform, you should have this
disabled - it provides a performance boost for Marvell platforms, but
degrades performance everywhere else.  Please ensure that you disable
CONFIG_UACCESS_WITH_MEMCPY.

Signed-off-by: Jean-Christian de Rivaz <jc@eclis.ch>
---
 arch/arm/configs/at91_dt_defconfig |    1 -
 arch/arm/configs/sama5_defconfig   |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 090c5b2..8a374e9 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -21,7 +21,6 @@ CONFIG_SOC_SAM_V4_V5=y
 CONFIG_SOC_AT91RM9200=y
 CONFIG_SOC_AT91SAM9=y
 CONFIG_AEABI=y
-CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 31eb951..84fc70f 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -19,7 +19,6 @@ CONFIG_SOC_SAM_V7=y
 CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
 CONFIG_AEABI=y
-CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
-- 
1.7.10.4
