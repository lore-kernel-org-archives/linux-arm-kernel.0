From: jiri.pinkava@vscht.cz (jiri.pinkava at vscht.cz)
Date: Wed, 6 Apr 2011 01:06:05 +0200
Subject: [PATCH 3/6] n30: Clean-up UARTs configuration
In-Reply-To: <1302044768-7774-1-git-send-email-jiri.pinkava@vscht.cz>
References: <1302044768-7774-1-git-send-email-jiri.pinkava@vscht.cz>
Message-ID: <1302044768-7774-4-git-send-email-jiri.pinkava@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiri Pinkava <jiri.pinkava@vscht.cz>

Replace numbers by names of constants defined in header files.

Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c                 |   28 +++++++++++++++-------
 arch/arm/plat-samsung/include/plat/regs-serial.h |    3 ++
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 408dd88..d98d7b5 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -55,32 +55,42 @@ static struct map_desc n30_iodesc[] __initdata = {
 	/* nothing here yet */
 };
 
+#define UCON	(S3C2410_UCON_DEFAULT | \
+		 S3C2443_UCON_RXERR_IRQEN)
+
+#define ULCON	(S3C2410_LCON_CS8 | \
+		 S3C2410_LCON_PNONE)
+
+#define UFCON	(S3C2410_UFCON_FIFOMODE | \
+		 S3C2410_UFCON_RXTRIG8 | \
+		 S3C2410_UFCON_TXTRIG4)
+
 static struct s3c2410_uartcfg n30_uartcfgs[] = {
 	/* Normal serial port */
 	[0] = {
 		.hwport	     = 0,
 		.flags	     = 0,
-		.ucon	     = 0x2c5,
-		.ulcon	     = 0x03,
-		.ufcon	     = 0x51,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
 	},
 	/* IR port */
 	[1] = {
 		.hwport	     = 1,
 		.flags	     = 0,
 		.uart_flags  = UPF_CONS_FLOW,
-		.ucon	     = 0x2c5,
-		.ulcon	     = 0x43,
-		.ufcon	     = 0x51,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON | S3C2410_LCON_IRM,
+		.ufcon	     = UFCON,
 	},
 	/* On the N30 the bluetooth controller is connected here.
 	 * On the N35 and variants the GPS receiver is connected here. */
 	[2] = {
 		.hwport	     = 2,
 		.flags	     = 0,
-		.ucon	     = 0x2c5,
-		.ulcon	     = 0x03,
-		.ufcon	     = 0x51,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
 	},
 };
 
diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index 788837e..c64beca 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -114,6 +114,9 @@
 
 #define S3C2410_UFCON_FIFOMODE	  (1<<0)
 #define S3C2410_UFCON_TXTRIG0	  (0<<6)
+#define S3C2410_UFCON_TXTRIG4	  (1<<6)
+#define S3C2410_UFCON_TXTRIG8	  (2<<6)
+#define S3C2410_UFCON_TXTRIG12	  (3<<6)
 #define S3C2410_UFCON_RXTRIG8	  (1<<4)
 #define S3C2410_UFCON_RXTRIG12	  (2<<4)
 
-- 
1.7.4.2
