From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  8 Jun 2017 18:10:45 +0200
Subject: [PATCH 34/35] ARM: s5pv210_defconfig: Save defconfig
In-Reply-To: <20170608160836.12196-1-krzk@kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
Message-ID: <20170608161049.12421-34-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generate new defconfig to get rid of obsolete Kconfig entries:
 - S3C_LOWLEVEL_UART_PORT and S3C_DEV_FB are invalid for S5P;
 - S5PV210_SETUP_FB_24BPP is gone;
 - rest of entries is being removed by default values;

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/s5pv210_defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index ddf7f75ba8d9..09b5a7386414 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -11,9 +11,6 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_ARCH_S5PV210=y
-CONFIG_S3C_LOWLEVEL_UART_PORT=1
-CONFIG_S3C_DEV_FB=y
-CONFIG_S5PV210_SETUP_FB_24BPP=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
@@ -36,7 +33,6 @@ CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
 CONFIG_HW_RANDOM=y
 # CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.9.3
