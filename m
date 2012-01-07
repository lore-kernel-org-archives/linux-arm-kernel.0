From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 07 Jan 2012 20:47:47 +0900
Subject: [PATCH] ARM: S3C24XX: Fix build error for missing
 <mach/system-reset.h>
Message-ID: <010101cccd32$2cf0cfe0$86d26fa0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the arch/arm/mach-s3c2410/include/mach/system-reset.h has
been removed by commit f88b8979 ("ARM: restart: remove the now
empty arch_reset()"), so the inclusion of <mach/system-reset.h>
should be removed at the plat-s3c24xx/cpu.c file.

The build error happens like following:
  arch/arm/plat-s3c24xx/cpu.c:41: fatal error: mach/system-reset.h: No such file or directory

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Russell,

I think, you missed removing this in your patch.
If you have patches to send to Linus for this merge window,
could you please send this together? Or...?

 arch/arm/plat-s3c24xx/cpu.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 1121df1..21f1fda 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -38,8 +38,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/system-reset.h>
-
 #include <mach/regs-gpio.h>
 #include <plat/regs-serial.h>
 
-- 
1.7.1
