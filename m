From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 08 Feb 2012 10:25:13 +0900
Subject: [PATCH] ARM: EXYNOS: Configure ARM_NR_BANKS for EXYNOS SoC
Message-ID: <003201cce600$81c8f100$855ad300$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch increases the number of bank for EXYNOS4 and EXYNOS5
to support bigger than 2GB memory on it.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f9d7c47..d646810 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1134,7 +1134,7 @@ source arch/arm/mm/Kconfig

 config ARM_NR_BANKS
 	int
-	default 16 if ARCH_EP93XX
+	default 16 if ARCH_EP93XX || ARCH_EXYNOS4 || ARCH_EXYNOS5
 	default 8

 config IWMMXT
--
1.7.1
