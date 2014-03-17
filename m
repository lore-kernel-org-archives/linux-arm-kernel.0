From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Mar 2014 07:14:36 +0900
Subject: [PATCH v3 2/3] arm64: defconfig: Enable ARCH_GH7 by default
In-Reply-To: <1395094477-8921-1-git-send-email-kgene.kim@samsung.com>
References: <1395094477-8921-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1395094477-8921-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Samsung GH7 SoC in arm64/Kconfig and
enable Samsung GH7 based SSDK_GH7 in single defconfig for arm64.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig           | 5 +++++
 arch/arm64/boot/dts/Makefile | 1 +
 arch/arm64/configs/defconfig | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dd4327f..7d71823 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -111,6 +111,11 @@ source "kernel/Kconfig.freezer"
 
 menu "Platform selection"
 
+config ARCH_GH7
+	bool "Samsung ARMv8 GH7 SoC"
+	help
+	  This enables support for Samsung GH7 SoC
+
 config ARCH_VEXPRESS
 	bool "ARMv8 software model (Versatile Express)"
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index c52bdb0..54fb0cf 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,3 +1,4 @@
+dtb-$(CONFIG_ARCH_GH7) += samsung-ssdk-gh7.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
 dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
 
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 84139be..d683890 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -23,6 +23,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_GH7=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
 CONFIG_SMP=y
-- 
1.8.2.1.339.g52a3e01
