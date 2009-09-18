From: akpm@linux-foundation.org (akpm at linux-foundation.org)
Date: Fri, 18 Sep 2009 12:44:17 -0700
Subject: [patch 1/3] s3c: fix check of index into s3c_gpios[]
Message-ID: <200909181944.n8IJiHEe008747@imap1.linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roel Kluin <roel.kluin@gmail.com>

The check of the s3c_gpios[] index had an off-by-one.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/plat-s3c/gpio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/arm/plat-s3c/gpio.c~s3c-fix-check-of-index-into-s3c_gpios arch/arm/plat-s3c/gpio.c
--- a/arch/arm/plat-s3c/gpio.c~s3c-fix-check-of-index-into-s3c_gpios
+++ a/arch/arm/plat-s3c/gpio.c
@@ -28,7 +28,7 @@ static __init void s3c_gpiolib_track(str
 
 	gpn = chip->chip.base;
 	for (i = 0; i < chip->chip.ngpio; i++, gpn++) {
-		BUG_ON(gpn > ARRAY_SIZE(s3c_gpios));
+		BUG_ON(gpn >= ARRAY_SIZE(s3c_gpios));
 		s3c_gpios[gpn] = chip;
 	}
 }
_
