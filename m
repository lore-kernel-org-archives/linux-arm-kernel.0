From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 09 Feb 2012 09:51:11 +0900
Subject: [PATCHv2] ARM: EXYNOS: Config ARM_NR_BANKS for EXYNOS SoC
Message-ID: <000301cce6c4$eb2c9dd0$c185d970$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch increases the number of banks for EXYNOS4 and EXYNOS5 to
support bigger than 2GB memory on it.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f9d7c47..877dd61 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1134,7 +1134,7 @@ source arch/arm/mm/Kconfig

 config ARM_NR_BANKS
 	int
-	default 16 if ARCH_EP93XX
+	default 16 if ARCH_EP93XX || ARCH_EXYNOS
 	default 8

 config IWMMXT
--
1.7.1
