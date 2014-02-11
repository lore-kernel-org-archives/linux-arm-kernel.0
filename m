From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Feb 2014 11:59:42 +0530
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1392100183-30930-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Samsung GH7 SoC in arm64/Kconfig.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig           |    5 +++++
 arch/arm64/boot/dts/Makefile |    1 +
 2 files changed, 6 insertions(+)

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
 
-- 
1.7.10.4
