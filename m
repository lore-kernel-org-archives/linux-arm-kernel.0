From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 09 Jun 2010 11:39:03 +0200
Subject: [PATCH 1/3] s3c64xx: Fix build without SDHCI controllers
In-Reply-To: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
References: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1276076345-24370-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following compilation problem if only NCP machine
is selected:

arch/arm/mach-s3c64xx/s3c6410.c: In function ?s3c6410_map_io?:
arch/arm/mach-s3c64xx/s3c6410.c:51: error: implicit declaration of function ?s3c6410_default_sdhci2?

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/sdhci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 13f9fb2..c2044e5 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -166,6 +166,7 @@ static inline void s3c6410_default_sdhci2(void) { }
 #else
 static inline void s3c6410_default_sdhci0(void) { }
 static inline void s3c6410_default_sdhci1(void) { }
+static inline void s3c6410_default_sdhci2(void) { }
 static inline void s3c6400_default_sdhci0(void) { }
 static inline void s3c6400_default_sdhci1(void) { }
 
-- 
1.7.1.240.g225c
