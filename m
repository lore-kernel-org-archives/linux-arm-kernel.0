From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Sat, 09 Jan 2010 05:04:30 -0500
Subject: [PATCH] S3C: Remove unneeded __init symbols
Message-ID: <20100109100430.5258.8254.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two functions defined with __init are also exported.
Let's remove the __init symbols in order to avoid two warnings.

Signed-off-by: Nelson Castillo <arhuaco@freaks-unidos.net>
---

 arch/arm/plat-s3c/dev-nand.c |    2 +-
 arch/arm/plat-s3c24xx/devs.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c/dev-nand.c b/arch/arm/plat-s3c/dev-nand.c
index 84808cc..a1137a7 100644
--- a/arch/arm/plat-s3c/dev-nand.c
+++ b/arch/arm/plat-s3c/dev-nand.c
@@ -79,7 +79,7 @@ static int __init s3c_nand_copy_set(struct s3c2410_nand_set *set)
 	return 0;
 }
 
-void __init s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
+void s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
 {
 	struct s3c2410_platform_nand *npd;
 	int size;
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 7f686a3..267f36a 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -193,7 +193,7 @@ EXPORT_SYMBOL(s3c_device_ts);
 
 static struct s3c2410_ts_mach_info s3c2410ts_info;
 
-void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_info)
+void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_info)
 {
 	memcpy(&s3c2410ts_info, hard_s3c2410ts_info, sizeof(struct s3c2410_ts_mach_info));
 	s3c_device_ts.dev.platform_data = &s3c2410ts_info;
