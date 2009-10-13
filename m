From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 13 Oct 2009 10:11:06 +0200
Subject: [PATCH 01/17] ARM: MM: use 64bytes of L1 cache on plat S5PC1xx
In-Reply-To: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung S5PC1xx SoCs are Coretex8 based, so use 64 bytes of L1 cache
line instead of the default 32 bytes.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index e993140..9cf7706 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -777,5 +777,5 @@ config CACHE_XSC3L2
 
 config ARM_L1_CACHE_SHIFT
 	int
-	default 6 if ARCH_OMAP3
+	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
 	default 5
-- 
1.6.4
