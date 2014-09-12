From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 12 Sep 2014 20:56:30 +0530
Subject: [PATCH v4 6/8] arm64: exynos7: Enable ARMv8 based Exynos7 (SoC)
 support
In-Reply-To: <1410535592-5782-1-git-send-email-ch.naveen@samsung.com>
References: <1410535592-5782-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1410535592-5782-8-git-send-email-ch.naveen@samsung.com>
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
 arch/arm64/Kconfig |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd4e81a..b4d1dc2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -134,6 +134,18 @@ source "kernel/Kconfig.freezer"
 
 menu "Platform selection"
 
+config ARCH_EXYNOS
+	bool
+	help
+	  This enables support for Samsung Exynos SoC family
+
+config ARCH_EXYNOS7
+	bool "ARMv8 based Samsung Exynos7"
+	select ARCH_EXYNOS
+	select COMMON_CLK_SAMSUNG
+	help
+	  This enables support for Samsung Exynos7 SoC family
+
 config ARCH_VEXPRESS
 	bool "ARMv8 software model (Versatile Express)"
 	select ARCH_REQUIRE_GPIOLIB
-- 
1.7.9.5
