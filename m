From: rric@kernel.org (Robert Richter)
Date: Fri, 12 Sep 2014 19:49:46 +0200
Subject: [PATCH v3 3/4] arm64,
 thunder: Add Kconfig option for Cavium Thunder SoC Family
In-Reply-To: <1410544187-15876-1-git-send-email-rric@kernel.org>
References: <1410544187-15876-1-git-send-email-rric@kernel.org>
Message-ID: <1410544187-15876-4-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This introduces ARCH_THUNDER to enable soc specific drivers and dtb
files.

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/Kconfig           | 5 +++++
 arch/arm64/boot/dts/Makefile | 3 +--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 67fca2ea81a7..ff9179ba63fb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -134,6 +134,11 @@ source "kernel/Kconfig.freezer"
 
 menu "Platform selection"
 
+config ARCH_THUNDER
+	bool "Cavium Inc. Thunder SoC Family"
+	help
+	  This enables support for Cavium's Thunder Family of SoCs.
+
 config ARCH_VEXPRESS
 	bool "ARMv8 software model (Versatile Express)"
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index c2e8e4661a90..f8001a62029c 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,8 +1,7 @@
+dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
 dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
 
-dtb-y += thunder-88xx.dtb
-
 targets += dtbs
 targets += $(dtb-y)
 
-- 
2.1.0
