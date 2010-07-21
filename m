From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Jul 2010 16:00:06 +0900
Subject: [PATCH] ARM: S5P: Changes the definition name of default UART
	registers
Message-ID: <1279695606-26868-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the definition name of default UCON, ULCON, and
UFCON UART registers from ARCH(SoC) to Machine(Board). Because it
is board specific UART configuration.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/mach-smdk6440.c |   30 +++++++++++-----------
 arch/arm/mach-s5p6442/mach-smdk6442.c |   24 +++++++++---------
 arch/arm/mach-s5pc100/mach-smdkc100.c |   30 +++++++++++-----------
 arch/arm/mach-s5pv210/mach-aquila.c   |   42 ++++++++++++++++++---------------
 arch/arm/mach-s5pv210/mach-goni.c     |   42 ++++++++++++++++++---------------
 arch/arm/mach-s5pv210/mach-smdkc110.c |   30 +++++++++++-----------
 arch/arm/mach-s5pv210/mach-smdkv210.c |   30 +++++++++++-----------
 7 files changed, 118 insertions(+), 110 deletions(-)

diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
index 8291fec..fedc142 100644
--- a/arch/arm/mach-s5p6440/mach-smdk6440.c
+++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
@@ -41,16 +41,16 @@
 #include <plat/adc.h>
 #include <plat/ts.h>
 
-#define S5P6440_UCON_DEFAULT    (S3C2410_UCON_TXILEVEL |	\
+#define SMDK6440_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
 				S3C2410_UCON_TXIRQMODE |	\
 				S3C2410_UCON_RXIRQMODE |	\
 				S3C2410_UCON_RXFIFO_TOI |	\
 				S3C2443_UCON_RXERR_IRQEN)
 
-#define S5P6440_ULCON_DEFAULT	S3C2410_LCON_CS8
+#define SMDK6440_ULCON_DEFAULT	S3C2410_LCON_CS8
 
-#define S5P6440_UFCON_DEFAULT   (S3C2410_UFCON_FIFOMODE |	\
+#define SMDK6440_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
 				S3C2440_UFCON_TXTRIG16 |	\
 				S3C2410_UFCON_RXTRIG8)
 
@@ -58,30 +58,30 @@ static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
 		.flags	     = 0,
-		.ucon	     = S5P6440_UCON_DEFAULT,
-		.ulcon	     = S5P6440_ULCON_DEFAULT,
-		.ufcon	     = S5P6440_UFCON_DEFAULT,
+		.ucon	     = SMDK6440_UCON_DEFAULT,
+		.ulcon	     = SMDK6440_ULCON_DEFAULT,
+		.ufcon	     = SMDK6440_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport	     = 1,
 		.flags	     = 0,
-		.ucon	     = S5P6440_UCON_DEFAULT,
-		.ulcon	     = S5P6440_ULCON_DEFAULT,
-		.ufcon	     = S5P6440_UFCON_DEFAULT,
+		.ucon	     = SMDK6440_UCON_DEFAULT,
+		.ulcon	     = SMDK6440_ULCON_DEFAULT,
+		.ufcon	     = SMDK6440_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport	     = 2,
 		.flags	     = 0,
-		.ucon	     = S5P6440_UCON_DEFAULT,
-		.ulcon	     = S5P6440_ULCON_DEFAULT,
-		.ufcon	     = S5P6440_UFCON_DEFAULT,
+		.ucon	     = SMDK6440_UCON_DEFAULT,
+		.ulcon	     = SMDK6440_ULCON_DEFAULT,
+		.ufcon	     = SMDK6440_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport	     = 3,
 		.flags	     = 0,
-		.ucon	     = S5P6440_UCON_DEFAULT,
-		.ulcon	     = S5P6440_ULCON_DEFAULT,
-		.ufcon	     = S5P6440_UFCON_DEFAULT,
+		.ucon	     = SMDK6440_UCON_DEFAULT,
+		.ulcon	     = SMDK6440_ULCON_DEFAULT,
+		.ufcon	     = SMDK6440_UFCON_DEFAULT,
 	},
 };
 
diff --git a/arch/arm/mach-s5p6442/mach-smdk6442.c b/arch/arm/mach-s5p6442/mach-smdk6442.c
index 6e061be..8d8d042 100644
--- a/arch/arm/mach-s5p6442/mach-smdk6442.c
+++ b/arch/arm/mach-s5p6442/mach-smdk6442.c
@@ -27,16 +27,16 @@
 #include <plat/cpu.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
-#define S5P6442_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+#define SMDK6442_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
 				 S3C2410_UCON_TXIRQMODE |	\
 				 S3C2410_UCON_RXIRQMODE |	\
 				 S3C2410_UCON_RXFIFO_TOI |	\
 				 S3C2443_UCON_RXERR_IRQEN)
 
-#define S5P6442_ULCON_DEFAULT	S3C2410_LCON_CS8
+#define SMDK6442_ULCON_DEFAULT	S3C2410_LCON_CS8
 
-#define S5P6442_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+#define SMDK6442_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
 				 S5PV210_UFCON_TXTRIG4 |	\
 				 S5PV210_UFCON_RXTRIG4)
 
@@ -44,23 +44,23 @@ static struct s3c2410_uartcfg smdk6442_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
 		.flags		= 0,
-		.ucon		= S5P6442_UCON_DEFAULT,
-		.ulcon		= S5P6442_ULCON_DEFAULT,
-		.ufcon		= S5P6442_UFCON_DEFAULT,
+		.ucon		= SMDK6442_UCON_DEFAULT,
+		.ulcon		= SMDK6442_ULCON_DEFAULT,
+		.ufcon		= SMDK6442_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
 		.flags		= 0,
-		.ucon		= S5P6442_UCON_DEFAULT,
-		.ulcon		= S5P6442_ULCON_DEFAULT,
-		.ufcon		= S5P6442_UFCON_DEFAULT,
+		.ucon		= SMDK6442_UCON_DEFAULT,
+		.ulcon		= SMDK6442_ULCON_DEFAULT,
+		.ufcon		= SMDK6442_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
 		.flags		= 0,
-		.ucon		= S5P6442_UCON_DEFAULT,
-		.ulcon		= S5P6442_ULCON_DEFAULT,
-		.ufcon		= S5P6442_UFCON_DEFAULT,
+		.ucon		= SMDK6442_UCON_DEFAULT,
+		.ulcon		= SMDK6442_ULCON_DEFAULT,
+		.ufcon		= SMDK6442_UFCON_DEFAULT,
 	},
 };
 
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index bf1b927..9afe9f7 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -47,16 +47,16 @@
 #include <plat/ts.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
-#define S5PC100_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+#define SMDKC100_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
 				 S3C2410_UCON_TXIRQMODE |	\
 				 S3C2410_UCON_RXIRQMODE |	\
 				 S3C2410_UCON_RXFIFO_TOI |	\
 				 S3C2443_UCON_RXERR_IRQEN)
 
-#define S5PC100_ULCON_DEFAULT	S3C2410_LCON_CS8
+#define SMDKC100_ULCON_DEFAULT	S3C2410_LCON_CS8
 
-#define S5PC100_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+#define SMDKC100_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
 				 S3C2440_UFCON_RXTRIG8 |	\
 				 S3C2440_UFCON_TXTRIG16)
 
@@ -64,30 +64,30 @@ static struct s3c2410_uartcfg smdkc100_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
 		.flags	     = 0,
-		.ucon	     = S5PC100_UCON_DEFAULT,
-		.ulcon	     = S5PC100_ULCON_DEFAULT,
-		.ufcon	     = S5PC100_UFCON_DEFAULT,
+		.ucon	     = SMDKC100_UCON_DEFAULT,
+		.ulcon	     = SMDKC100_ULCON_DEFAULT,
+		.ufcon	     = SMDKC100_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport	     = 1,
 		.flags	     = 0,
-		.ucon	     = S5PC100_UCON_DEFAULT,
-		.ulcon	     = S5PC100_ULCON_DEFAULT,
-		.ufcon	     = S5PC100_UFCON_DEFAULT,
+		.ucon	     = SMDKC100_UCON_DEFAULT,
+		.ulcon	     = SMDKC100_ULCON_DEFAULT,
+		.ufcon	     = SMDKC100_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport	     = 2,
 		.flags	     = 0,
-		.ucon	     = S5PC100_UCON_DEFAULT,
-		.ulcon	     = S5PC100_ULCON_DEFAULT,
-		.ufcon	     = S5PC100_UFCON_DEFAULT,
+		.ucon	     = SMDKC100_UCON_DEFAULT,
+		.ulcon	     = SMDKC100_ULCON_DEFAULT,
+		.ufcon	     = SMDKC100_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport	     = 3,
 		.flags	     = 0,
-		.ucon	     = S5PC100_UCON_DEFAULT,
-		.ulcon	     = S5PC100_ULCON_DEFAULT,
-		.ufcon	     = S5PC100_UFCON_DEFAULT,
+		.ucon	     = SMDKC100_UCON_DEFAULT,
+		.ulcon	     = SMDKC100_ULCON_DEFAULT,
+		.ufcon	     = SMDKC100_UFCON_DEFAULT,
 	},
 };
 
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 0992618..a7762e6 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -37,53 +37,57 @@
 #include <plat/fb.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
-#define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+#define AQUILA_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
 				 S3C2410_UCON_TXIRQMODE |	\
 				 S3C2410_UCON_RXIRQMODE |	\
 				 S3C2410_UCON_RXFIFO_TOI |	\
 				 S3C2443_UCON_RXERR_IRQEN)
 
-#define S5PV210_ULCON_DEFAULT	S3C2410_LCON_CS8
+#define AQUILA_ULCON_DEFAULT	S3C2410_LCON_CS8
 
-#define S5PV210_UFCON_DEFAULT	S3C2410_UFCON_FIFOMODE
+#define AQUILA_UFCON_DEFAULT	S3C2410_UFCON_FIFOMODE
 
 static struct s3c2410_uartcfg aquila_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
+		.ucon		= AQUILA_UCON_DEFAULT,
+		.ulcon		= AQUILA_ULCON_DEFAULT,
 		/*
 		 * Actually UART0 can support 256 bytes fifo, but aquila board
 		 * supports 128 bytes fifo because of initial chip bug
 		 */
-		.ufcon		= S5PV210_UFCON_DEFAULT |
-			S5PV210_UFCON_TXTRIG128 | S5PV210_UFCON_RXTRIG128,
+		.ufcon		= (AQUILA_UFCON_DEFAULT |
+				   S5PV210_UFCON_TXTRIG128 |
+				   S5PV210_UFCON_RXTRIG128),
 	},
 	[1] = {
 		.hwport		= 1,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT |
-			S5PV210_UFCON_TXTRIG64 | S5PV210_UFCON_RXTRIG64,
+		.ucon		= AQUILA_UCON_DEFAULT,
+		.ulcon		= AQUILA_ULCON_DEFAULT,
+		.ufcon		= (AQUILA_UFCON_DEFAULT |
+				   S5PV210_UFCON_TXTRIG64 |
+				   S5PV210_UFCON_RXTRIG64),
 	},
 	[2] = {
 		.hwport		= 2,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT |
-			S5PV210_UFCON_TXTRIG16 | S5PV210_UFCON_RXTRIG16,
+		.ucon		= AQUILA_UCON_DEFAULT,
+		.ulcon		= AQUILA_ULCON_DEFAULT,
+		.ufcon		= (AQUILA_UFCON_DEFAULT |
+				   S5PV210_UFCON_TXTRIG16 |
+				   S5PV210_UFCON_RXTRIG16),
 	},
 	[3] = {
 		.hwport		= 3,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT |
-			S5PV210_UFCON_TXTRIG16 | S5PV210_UFCON_RXTRIG16,
+		.ucon		= AQUILA_UCON_DEFAULT,
+		.ulcon		= AQUILA_ULCON_DEFAULT,
+		.ufcon		= (AQUILA_UFCON_DEFAULT |
+				   S5PV210_UFCON_TXTRIG16 |
+				   S5PV210_UFCON_RXTRIG16),
 	},
 };
 
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 7b18505..e11df1a 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -37,49 +37,53 @@
 #include <plat/fb.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
-#define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+#define GONI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
 				 S3C2410_UCON_TXIRQMODE |	\
 				 S3C2410_UCON_RXIRQMODE |	\
 				 S3C2410_UCON_RXFIFO_TOI |	\
 				 S3C2443_UCON_RXERR_IRQEN)
 
-#define S5PV210_ULCON_DEFAULT	S3C2410_LCON_CS8
+#define GONI_ULCON_DEFAULT	S3C2410_LCON_CS8
 
-#define S5PV210_UFCON_DEFAULT	S3C2410_UFCON_FIFOMODE
+#define GONI_UFCON_DEFAULT	S3C2410_UFCON_FIFOMODE
 
 static struct s3c2410_uartcfg goni_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT |
-			S5PV210_UFCON_TXTRIG256 | S5PV210_UFCON_RXTRIG256,
+		.ucon		= GONI_UCON_DEFAULT,
+		.ulcon		= GONI_ULCON_DEFAULT,
+		.ufcon		= (GONI_UFCON_DEFAULT |
+				   S5PV210_UFCON_TXTRIG256 |
+				   S5PV210_UFCON_RXTRIG256),
 	},
 	[1] = {
 		.hwport		= 1,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT |
-			S5PV210_UFCON_TXTRIG64 | S5PV210_UFCON_RXTRIG64,
+		.ucon		= GONI_UCON_DEFAULT,
+		.ulcon		= GONI_ULCON_DEFAULT,
+		.ufcon		= (GONI_UFCON_DEFAULT |
+				   S5PV210_UFCON_TXTRIG64 |
+				   S5PV210_UFCON_RXTRIG64),
 	},
 	[2] = {
 		.hwport		= 2,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT |
-			S5PV210_UFCON_TXTRIG16 | S5PV210_UFCON_RXTRIG16,
+		.ucon		= GONI_UCON_DEFAULT,
+		.ulcon		= GONI_ULCON_DEFAULT,
+		.ufcon		= (GONI_UFCON_DEFAULT |
+				   S5PV210_UFCON_TXTRIG16 |
+				   S5PV210_UFCON_RXTRIG16),
 	},
 	[3] = {
 		.hwport		= 3,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT |
-			S5PV210_UFCON_TXTRIG16 | S5PV210_UFCON_RXTRIG16,
+		.ucon		= GONI_UCON_DEFAULT,
+		.ulcon		= GONI_ULCON_DEFAULT,
+		.ufcon		= (GONI_UFCON_DEFAULT |
+				   S5PV210_UFCON_TXTRIG16 |
+				   S5PV210_UFCON_RXTRIG16),
 	},
 };
 
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 723e607..5f35b2a 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -28,16 +28,16 @@
 #include <plat/ata.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
-#define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+#define SMDKC110_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
 				 S3C2410_UCON_TXIRQMODE |	\
 				 S3C2410_UCON_RXIRQMODE |	\
 				 S3C2410_UCON_RXFIFO_TOI |	\
 				 S3C2443_UCON_RXERR_IRQEN)
 
-#define S5PV210_ULCON_DEFAULT	S3C2410_LCON_CS8
+#define SMDKC110_ULCON_DEFAULT	S3C2410_LCON_CS8
 
-#define S5PV210_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+#define SMDKC110_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
 				 S5PV210_UFCON_TXTRIG4 |	\
 				 S5PV210_UFCON_RXTRIG4)
 
@@ -45,30 +45,30 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.ucon		= SMDKC110_UCON_DEFAULT,
+		.ulcon		= SMDKC110_ULCON_DEFAULT,
+		.ufcon		= SMDKC110_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.ucon		= SMDKC110_UCON_DEFAULT,
+		.ulcon		= SMDKC110_ULCON_DEFAULT,
+		.ufcon		= SMDKC110_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.ucon		= SMDKC110_UCON_DEFAULT,
+		.ulcon		= SMDKC110_ULCON_DEFAULT,
+		.ufcon		= SMDKC110_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport		= 3,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.ucon		= SMDKC110_UCON_DEFAULT,
+		.ulcon		= SMDKC110_ULCON_DEFAULT,
+		.ufcon		= SMDKC110_UFCON_DEFAULT,
 	},
 };
 
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index cc902c1..64330b7 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -30,16 +30,16 @@
 #include <plat/ata.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
-#define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+#define SMDKV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
 				 S3C2410_UCON_TXIRQMODE |	\
 				 S3C2410_UCON_RXIRQMODE |	\
 				 S3C2410_UCON_RXFIFO_TOI |	\
 				 S3C2443_UCON_RXERR_IRQEN)
 
-#define S5PV210_ULCON_DEFAULT	S3C2410_LCON_CS8
+#define SMDKV210_ULCON_DEFAULT	S3C2410_LCON_CS8
 
-#define S5PV210_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+#define SMDKV210_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
 				 S5PV210_UFCON_TXTRIG4 |	\
 				 S5PV210_UFCON_RXTRIG4)
 
@@ -47,30 +47,30 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.ucon		= SMDKV210_UCON_DEFAULT,
+		.ulcon		= SMDKV210_ULCON_DEFAULT,
+		.ufcon		= SMDKV210_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.ucon		= SMDKV210_UCON_DEFAULT,
+		.ulcon		= SMDKV210_ULCON_DEFAULT,
+		.ufcon		= SMDKV210_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.ucon		= SMDKV210_UCON_DEFAULT,
+		.ulcon		= SMDKV210_ULCON_DEFAULT,
+		.ufcon		= SMDKV210_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport		= 3,
 		.flags		= 0,
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ulcon		= S5PV210_ULCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.ucon		= SMDKV210_UCON_DEFAULT,
+		.ulcon		= SMDKV210_ULCON_DEFAULT,
+		.ufcon		= SMDKV210_UFCON_DEFAULT,
 	},
 };
 
-- 
1.6.2.5
