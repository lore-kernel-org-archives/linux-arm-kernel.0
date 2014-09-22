From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Mon, 22 Sep 2014 10:17:06 +0530
Subject: [PATCH v5 6/8] arm64: exynos7: Enable ARMv8 based Exynos7 (SoC)
 support
In-Reply-To: <1411361228-18279-1-git-send-email-a.kesavan@samsung.com>
References: <1411361228-18279-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1411361228-18279-7-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alim Akhtar <alim.akhtar@samsung.com>

This patch adds the necessary Kconfig entries to enable
support for the ARMv8 based Exynos7 SoC.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
Tested-by: Thomas Abraham <thomas.ab@samsung.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2ca2ebd..1874e1a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -137,6 +137,18 @@ source "kernel/Kconfig.freezer"
 
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
2.1.0
