From: cbz@baozis.org (Chen Baozi)
Date: Sat,  7 Feb 2015 13:07:14 +0800
Subject: [PATCH 1/3] arm64: Add Kconfig option for Phytium FT SoC Family.
In-Reply-To: <1423285636-8623-1-git-send-email-cbz@baozis.org>
References: <1423285636-8623-1-git-send-email-cbz@baozis.org>
Message-ID: <1423285636-8623-2-git-send-email-cbz@baozis.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces ARCH_PHYTIUM to enable SoC specific drivers and dtb
files.

Signed-off-by: Chen Baozi <chenbaozi@kylinos.com.cn>
---
 arch/arm64/Kconfig           | 5 +++++
 arch/arm64/configs/defconfig | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1f9a20..9cfa320 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -153,6 +153,11 @@ config ARCH_SEATTLE
 	help
 	  This enables support for AMD Seattle SOC Family
 
+config ARCH_PHYTIUM
+	bool "Phytium FT SoC Family"
+	help
+	  This enables support for Phytium FT SoC Family.
+
 config ARCH_THUNDER
 	bool "Cavium Inc. Thunder SoC Family"
 	help
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5376d90..df50c54 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -31,6 +31,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_PHYTIUM=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
@@ -86,6 +87,7 @@ CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
2.1.4
