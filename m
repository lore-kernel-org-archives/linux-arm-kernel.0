From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 27 Nov 2014 16:35:12 +0900
Subject: [PATCH 15/19] arm64: exynos5433: Enable ARMv8-based Exynos5433 SoC
 support
In-Reply-To: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1417073716-22997-16-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the necessary Kconfig entries to enable
support for the ARMv8 based Exynos5433 SoC.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
---
 arch/arm64/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f4536e0..8a5e8a0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -152,6 +152,16 @@ config ARCH_EXYNOS
 	help
 	  This enables support for Samsung Exynos SoC family
 
+config ARCH_EXYNOS5433
+	bool "ARMv8 based Samsung Exynos5433"
+	select ARCH_EXYNOS
+	select COMMON_CLK_SAMSUNG
+	select PINCTRL
+	select PINCTRL_EXYNOS
+
+	help
+	  This enables support for Samsung Exynos5433 SoC family
+
 config ARCH_EXYNOS7
 	bool "ARMv8 based Samsung Exynos7"
 	select ARCH_EXYNOS
-- 
1.8.5.5
