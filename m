From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 30 Jul 2015 17:35:22 +0800
Subject: [PATCH v5 2/2] arm64: Enable Marvell Berlin SoC family in Kconfig and
 defconfig
In-Reply-To: <1438248922-2919-1-git-send-email-jszhang@marvell.com>
References: <1438248922-2919-1-git-send-email-jszhang@marvell.com>
Message-ID: <1438248922-2919-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces ARCH_BERLIN to enable Marvell Berlin SoC family in
Kconfig and defconfig.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 arch/arm64/configs/defconfig | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index e2deb18..23800a1 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -5,6 +5,12 @@ config ARCH_BCM_IPROC
 	help
 	  This enables support for Broadcom iProc based SoCs
 
+config ARCH_BERLIN
+	bool "Marvell Berlin SoC Family"
+	select DW_APB_ICTL
+	help
+	  This enables support for Marvell Berlin SoC Family
+
 config ARCH_EXYNOS
 	bool
 	help
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 913f121..34d71dd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -32,6 +32,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_ARCH_BCM_IPROC=y
+CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_EXYNOS7=y
 CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_ARCH_HISI=y
-- 
2.5.0
