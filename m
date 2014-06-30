From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 30 Jun 2014 22:20:08 +0300
Subject: [PATCH 5/6] ARM: s3c24xx: Kconfig: Fix unmet dependency on
 S3C2440_PLL_* symbols for S3C2442
In-Reply-To: <1404156009-3919-1-git-send-email-anarsoul@gmail.com>
References: <1404156009-3919-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1404156009-3919-5-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's possible to build kernel with S3C2442, but without S3C2440 support, and
some S3C2442 machines depend on CONFIG_S3C2440_PLL_16934400

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c24xx/Kconfig | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 8c2a7f3..2305a5f 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -437,12 +437,7 @@ config MACH_S3C2416_DT
 
 endif	# CPU_S3C2416
 
-if CPU_S3C2440
-
-config S3C2440_DMA
-	bool
-	help
-	  Support for S3C2440 specific DMA code5A
+if CPU_S3C2440 || CPU_S3C2442
 
 config S3C2440_XTAL_12000000
 	bool
@@ -469,6 +464,14 @@ config S3C2440_PLL_16934400
 	default y if S3C24XX_PLL
 	help
 	  PLL tables for S3C2440 or S3C2442 CPUs with 16.934MHz crystals.
+endif
+
+if CPU_S3C2440
+
+config S3C2440_DMA
+	bool
+	help
+	  Support for S3C2440 specific DMA code5A
 
 comment "S3C2440 Boards"
 
-- 
2.0.0
