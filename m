From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 12 Sep 2012 21:28:55 +0200
Subject: [PATCH] arch/arm/mach-s3c24xx/mach-h1940.c: delete double assignment
Message-ID: <1347478135-744-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Delete successive assignments to the same location.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression i;
@@

*i = ...;
 i = ...;
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not compiled, and this may change the behavior of the code.  Without this
change, check_gpio2 could possibly be used uninitialized later.

 arch/arm/mach-s3c24xx/mach-h1940.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index bb8d008..477778c 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -380,7 +380,7 @@ int h1940_led_blink_set(unsigned gpio, int state,
 	default:
 		blink_gpio = S3C2410_GPA(3);
 		check_gpio1 = S3C2410_GPA(1);
-		check_gpio1 = S3C2410_GPA(7);
+		check_gpio2 = S3C2410_GPA(7);
 		break;
 	}
 
