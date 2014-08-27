From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Wed, 27 Aug 2014 15:14:20 +0530
Subject: [PATCH 13/14] arm64: exynos7: Enable ARMv8 based Exynos7 (SoC) support
In-Reply-To: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1409132660-1898-5-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alim Akhtar <alim.akhtar@samsung.com>

This patch adds the necessary Kconfig entries to enable
support for the ARMv8 based Exynos7 SoC.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd4e81a..d555558 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -134,6 +134,23 @@ source "kernel/Kconfig.freezer"
 
 menu "Platform selection"
 
+config ARCH_EXYNOS7
+	bool "ARMv8 based SAMSUNG EXYNOS7"
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select CLKSRC_OF
+	select COMMON_CLK_SAMSUNG
+	select GPIOLIB
+	select PINCTRL
+	select PINCTRL_EXYNOS
+	select RTC_CLASS
+	select HAVE_S3C_RTC
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select HAVE_CLK
+	select HAVE_SMP
+	help
+	  This enables support for SAMSUNG exynos7 SoC family
+
 config ARCH_VEXPRESS
 	bool "ARMv8 software model (Versatile Express)"
 	select ARCH_REQUIRE_GPIOLIB
-- 
1.7.9.5
