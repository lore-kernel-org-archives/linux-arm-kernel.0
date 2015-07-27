From: rjui@broadcom.com (Ray Jui)
Date: Mon, 27 Jul 2015 15:42:20 -0700
Subject: [PATCH v5 3/4] arm64: Add Broadcom iProc family support
In-Reply-To: <1438036941-27210-1-git-send-email-rjui@broadcom.com>
References: <1438036941-27210-1-git-send-email-rjui@broadcom.com>
Message-ID: <1438036941-27210-4-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to Broadcom's iProc family of arm64 based SoCs
in the arm64 Kconfig and defconfig files

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/Kconfig.platforms |    5 +++++
 arch/arm64/configs/defconfig |    1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index f7e4327..e2deb18 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -1,5 +1,10 @@
 menu "Platform selection"
 
+config ARCH_BCM_IPROC
+	bool "Broadcom iProc SoC Family"
+	help
+	  This enables support for Broadcom iProc based SoCs
+
 config ARCH_EXYNOS
 	bool
 	help
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 506b466..913f121 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -31,6 +31,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_EXYNOS7=y
 CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_ARCH_HISI=y
-- 
1.7.9.5
