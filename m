From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 17 Jan 2012 22:12:50 +0100
Subject: [PATCH 3/8] S3C2410: move s3c2410_baseclk_add to clock.h
In-Reply-To: <201201172210.51953.heiko@sntech.de>
References: <201201172210.51953.heiko@sntech.de>
Message-ID: <201201172212.50684.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

plat-samsung/clock.h currently keeps all the SoC specific clock
declarations. As we want to get rid of s3c2410.h altogether, move
the s3c2410_baseclk_add there too.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-samsung/include/plat/clock.h   |    3 +++
 arch/arm/plat-samsung/include/plat/s3c2410.h |    2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index 956af0b1..16a3c78 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -120,6 +120,9 @@ extern void s3c2412_setup_clocks(void);
 extern void s3c244x_setup_clocks(void);
 extern void s3c2443_setup_clocks(void);
 
+/* S3C2410 specific clock functions */
+
+extern int s3c2410_baseclk_add(void);
 
 /* S3C2443/S3C2416 specific clock functions */
 
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
1.7.2.3
