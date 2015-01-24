From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Sun, 25 Jan 2015 02:42:53 +0530
Subject: [RESEND PATCH v7 5/5] arm64: Add support for FSL's LS2085A SoC in
 Kconfig and defconfig
In-Reply-To: <1422133973-16460-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1422133973-16460-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1422133973-16460-6-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for FSL's LS2085A SoC in the arm64 Kconfig
and defconfig files.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Arnab Basu <arnab_basu@rocketmail.com>
---
 arch/arm64/Kconfig           |    5 +++++
 arch/arm64/configs/defconfig |    1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ac9afde..e0798cd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -141,6 +141,11 @@ source "kernel/Kconfig.freezer"
 
 menu "Platform selection"
 
+config ARCH_FSL_LS2085A
+	bool "Freescale LS2085A SOC"
+	help
+	  This enables support for Freescale LS2085A SOC.
+
 config ARCH_THUNDER
 	bool "Cavium Inc. Thunder SoC Family"
 	help
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9cd37de..29eff9f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -32,6 +32,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
-- 
1.7.9.5
