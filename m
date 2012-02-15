From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:55:39 +0900
Subject: [PATCH 05/12] ARM: S3C2410: move s3c2410_baseclk_add to clock.h
In-Reply-To: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329346545-16373-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko@sntech.de>

plat-samsung/clock.h currently keeps all the SoC specific clock
declarations. As we want to get rid of s3c2410.h altogether, move
the s3c2410_baseclk_add there too.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/include/plat/clock.h   |    4 ++++
 arch/arm/plat-samsung/include/plat/s3c2410.h |    2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index 42bbe3d..3b5a9dc 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -120,6 +120,10 @@ extern void s3c2412_setup_clocks(void);
 extern void s3c244x_setup_clocks(void);
 extern void s3c2443_setup_clocks(void);
 
+/* S3C2410 specific clock functions */
+
+extern int s3c2410_baseclk_add(void);
+
 /* S3C2443/S3C2416 specific clock functions */
 
 typedef unsigned int (*pll_fn)(unsigned int reg, unsigned int base);
diff --git a/arch/arm/plat-samsung/include/plat/s3c2410.h b/arch/arm/plat-samsung/include/plat/s3c2410.h
index 3986497..55b0e5f 100644
--- a/arch/arm/plat-samsung/include/plat/s3c2410.h
+++ b/arch/arm/plat-samsung/include/plat/s3c2410.h
@@ -29,5 +29,3 @@ extern void s3c2410_init_clocks(int xtal);
 #define s3c2410_init NULL
 #define s3c2410a_init NULL
 #endif
-
-extern int s3c2410_baseclk_add(void);
-- 
1.7.4.4
