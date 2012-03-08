From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu,  8 Mar 2012 01:48:36 -0800
Subject: [PATCH] ARM: S3C2440: Fixed build error for s3c244x
Message-ID: <1331200116-2424-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed following:
arch/arm/mach-s3c2440/s3c244x.c: In function 's3c244x_restart':
arch/arm/mach-s3c2440/s3c244x.c:209: error: expected declaration or statement at end of input
make[1]: *** [arch/arm/mach-s3c24xx/s3c244x.o] Error 1
make: *** [arch/arm/mach-s3c24xx] Error 2

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Hi Arnd, Olof,

This happened when I applied Heiko's 'Fix restart on S3C2442'.
It was my fault :( and this should be sent before release v3.3.

Please pick this up.

Thanks.
Kgene.

 arch/arm/mach-s3c2440/s3c244x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/s3c244x.c b/arch/arm/mach-s3c2440/s3c244x.c
index 744930a..d15852f 100644
--- a/arch/arm/mach-s3c2440/s3c244x.c
+++ b/arch/arm/mach-s3c2440/s3c244x.c
@@ -207,3 +207,4 @@ void s3c244x_restart(char mode, const char *cmd)
 
 	/* we'll take a jump through zero as a poor second */
 	soft_restart(0);
+}
-- 
1.7.4.4
