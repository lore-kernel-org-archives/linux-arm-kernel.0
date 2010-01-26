From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:02:53 +0000
Subject: [PATCH] ARM: S3C64XX: Remove useless IO descriptor from S3C6410
In-Reply-To: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
References: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264489385-13345-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iotable in arch/arm/mach-s3c64xx/s3c6410.c is currently empty and
therefore can be removed from the build.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/s3c6410.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index dd55c6a..185f15c 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -41,20 +41,8 @@
 #include <plat/s3c6400.h>
 #include <plat/s3c6410.h>
 
-/* Initial IO mappings */
-
-static struct map_desc s3c6410_iodesc[] __initdata = {
-};
-
-/* s3c6410_map_io
- *
- * register the standard cpu IO areas
-*/
-
 void __init s3c6410_map_io(void)
 {
-	iotable_init(s3c6410_iodesc, ARRAY_SIZE(s3c6410_iodesc));
-
 	/* initialise device information early */
 	s3c6410_default_sdhci0();
 	s3c6410_default_sdhci1();
-- 
1.6.0.4
