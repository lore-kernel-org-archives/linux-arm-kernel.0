From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  8 Jun 2017 18:10:46 +0200
Subject: [PATCH 35/35] ARM: tct_hammer_defconfig: Save defconfig
In-Reply-To: <20170608160836.12196-1-krzk@kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
Message-ID: <20170608161049.12421-35-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generate new defconfig to get rid of obsolete Kconfig entries:
 - BUGVERBOSE was changed into DEBUG_BUGVERBOSE and will be enabled by
   default (it is useful);
 - DETECT_SOFTLOCKUP was changed into LOCKUP_DETECTOR;
 - rest of entries is being removed by default values;

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/tct_hammer_defconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/configs/tct_hammer_defconfig b/arch/arm/configs/tct_hammer_defconfig
index 71a2e0fb70f5..d0a9e5dd9135 100644
--- a/arch/arm/configs/tct_hammer_defconfig
+++ b/arch/arm/configs/tct_hammer_defconfig
@@ -7,7 +7,6 @@ CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
-# CONFIG_BUGVERBOSE is not set
 # CONFIG_ELF_CORE is not set
 # CONFIG_SHMEM is not set
 CONFIG_SLOB=y
@@ -34,14 +33,12 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=10240
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT_CONSOLE is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_USB=y
 CONFIG_USB_MON=y
 CONFIG_USB_OHCI_HCD=y
@@ -57,7 +54,5 @@ CONFIG_JFFS2_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_DETECT_SOFTLOCKUP is not set
 CONFIG_DEBUG_LL=y
 CONFIG_CRC_CCITT=y
-- 
2.9.3
