From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 17 May 2010 08:22:35 +0100
Subject: [PATCH 3/6] ARM: S3C24XX: Start cleanup of GPIO numbering
In-Reply-To: <1274080958-369-1-git-send-email-ben-linux@fluff.org>
References: <1274080958-369-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274080958-369-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Start cleaning up the numbering of GPIO banks by removing the old
bank start definitions currently being used by some of the header
files.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/include/mach/gpio-nrs.h |    5 -----
 arch/arm/mach-s3c2412/gpio.c                  |    8 ++++----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h b/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
index f3182ff..ad94e1a 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
@@ -16,12 +16,7 @@
 
 #define S3C2410_GPIONO(bank,offset) ((bank) + (offset))
 
-#define S3C2410_GPIO_BANKA   (32*0)
-#define S3C2410_GPIO_BANKB   (32*1)
 #define S3C2410_GPIO_BANKC   (32*2)
-#define S3C2410_GPIO_BANKD   (32*3)
-#define S3C2410_GPIO_BANKE   (32*4)
-#define S3C2410_GPIO_BANKF   (32*5)
 #define S3C2410_GPIO_BANKG   (32*6)
 #define S3C2410_GPIO_BANKH   (32*7)
 
diff --git a/arch/arm/mach-s3c2412/gpio.c b/arch/arm/mach-s3c2412/gpio.c
index f7afece..71c5793 100644
--- a/arch/arm/mach-s3c2412/gpio.c
+++ b/arch/arm/mach-s3c2412/gpio.c
@@ -33,14 +33,14 @@ int s3c2412_gpio_set_sleepcfg(unsigned int pin, unsigned int state)
 
 	offs *= 2;
 
-	if (pin < S3C2410_GPIO_BANKB)
+	if (pin < S3C2410_GPB(0))
 		return -EINVAL;
 
-	if (pin >= S3C2410_GPIO_BANKF &&
-	    pin <= S3C2410_GPIO_BANKG)
+	if (pin >= S3C2410_GPF(0) &&
+	    pin <= S3C2410_GPG(16))
 		return -EINVAL;
 
-	if (pin > (S3C2410_GPIO_BANKH + 32))
+	if (pin > S3C2410_GPH(16))
 		return -EINVAL;
 
 	local_irq_save(flags);
-- 
1.6.3.3
