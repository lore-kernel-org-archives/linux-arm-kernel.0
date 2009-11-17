From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 17 Nov 2009 08:47:54 +0100
Subject: [PATCH] ARM: MM: use 64bytes of L1 cache on plat S5PC1xx
Message-ID: <1258444074-20679-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5PC1xx SoCs are Coretex8 based, so use 64 bytes of L1 cache
line instead of the default 32 bytes.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9264d81..7b7d4c3 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -774,5 +774,5 @@ config CACHE_XSC3L2
 
 config ARM_L1_CACHE_SHIFT
 	int
-	default 6 if ARCH_OMAP3
+	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
 	default 5
-- 
1.6.4
