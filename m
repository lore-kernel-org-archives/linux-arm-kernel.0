From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Sun, 20 Jun 2010 10:13:54 +0900
Subject: [PATCH] ARM: SAMSUNG: Remove flags of struct s3c2410_uartcfg
Message-ID: <1276996434-32606-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flags of struct s3c2410_uartcfg is assigned to 0 to the all samsung
arch machines and it isn't used by samsung uart driver.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s3c2410/mach-amlm5900.c            |    3 ---
 arch/arm/mach-s3c2410/mach-bast.c                |    3 ---
 arch/arm/mach-s3c2410/mach-h1940.c               |    3 ---
 arch/arm/mach-s3c2410/mach-n30.c                 |    3 ---
 arch/arm/mach-s3c2410/mach-otom.c                |    3 ---
 arch/arm/mach-s3c2410/mach-qt2410.c              |    3 ---
 arch/arm/mach-s3c2410/mach-smdk2410.c            |    3 ---
 arch/arm/mach-s3c2410/mach-tct_hammer.c          |    3 ---
 arch/arm/mach-s3c2410/mach-vr1000.c              |    3 ---
 arch/arm/mach-s3c2412/mach-jive.c                |    3 ---
 arch/arm/mach-s3c2412/mach-smdk2413.c            |    3 ---
 arch/arm/mach-s3c2412/mach-vstms.c               |    3 ---
 arch/arm/mach-s3c2416/mach-smdk2416.c            |    3 ---
 arch/arm/mach-s3c2440/mach-anubis.c              |    2 --
 arch/arm/mach-s3c2440/mach-at2440evb.c           |    2 --
 arch/arm/mach-s3c2440/mach-gta02.c               |    3 ---
 arch/arm/mach-s3c2440/mach-mini2440.c            |    3 ---
 arch/arm/mach-s3c2440/mach-nexcoder.c            |    3 ---
 arch/arm/mach-s3c2440/mach-osiris.c              |    3 ---
 arch/arm/mach-s3c2440/mach-rx1950.c              |    3 ---
 arch/arm/mach-s3c2440/mach-rx3715.c              |    2 --
 arch/arm/mach-s3c2440/mach-smdk2440.c            |    3 ---
 arch/arm/mach-s3c2443/mach-smdk2443.c            |    3 ---
 arch/arm/mach-s3c64xx/mach-anw6410.c             |    2 --
 arch/arm/mach-s3c64xx/mach-hmt.c                 |    3 ---
 arch/arm/mach-s3c64xx/mach-ncp.c                 |    3 ---
 arch/arm/mach-s3c64xx/mach-smartq.c              |    3 ---
 arch/arm/mach-s3c64xx/mach-smdk6400.c            |    2 --
 arch/arm/mach-s3c64xx/mach-smdk6410.c            |    4 ----
 arch/arm/mach-s5p6440/mach-smdk6440.c            |    4 ----
 arch/arm/mach-s5p6442/mach-smdk6442.c            |    3 ---
 arch/arm/mach-s5pc100/mach-smdkc100.c            |    4 ----
 arch/arm/mach-s5pv210/mach-aquila.c              |    4 ----
 arch/arm/mach-s5pv210/mach-goni.c                |    4 ----
 arch/arm/mach-s5pv210/mach-smdkc110.c            |    4 ----
 arch/arm/mach-s5pv210/mach-smdkv210.c            |    4 ----
 arch/arm/plat-samsung/include/plat/regs-serial.h |    1 -
 37 files changed, 0 insertions(+), 111 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c2410/mach-amlm5900.c
index 34fc05a..cc7de3a 100644
--- a/arch/arm/mach-s3c2410/mach-amlm5900.c
+++ b/arch/arm/mach-s3c2410/mach-amlm5900.c
@@ -125,21 +125,18 @@ static struct map_desc amlm5900_iodesc[] __initdata = {
 static struct s3c2410_uartcfg amlm5900_uartcfgs[] = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index c1f90f6..75a2df0 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -183,7 +183,6 @@ static struct s3c24xx_uart_clksrc bast_serial_clocks[] = {
 static struct s3c2410_uartcfg bast_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
@@ -192,7 +191,6 @@ static struct s3c2410_uartcfg bast_uartcfgs[] __initdata = {
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
@@ -202,7 +200,6 @@ static struct s3c2410_uartcfg bast_uartcfgs[] __initdata = {
 	/* port 2 is not actually used */
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 779b45b..eec80f6 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -74,14 +74,12 @@ static struct map_desc h1940_iodesc[] __initdata = {
 static struct s3c2410_uartcfg h1940_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = 0x245,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x00,
@@ -89,7 +87,6 @@ static struct s3c2410_uartcfg h1940_uartcfgs[] __initdata = {
 	/* IR port */
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.uart_flags  = UPF_CONS_FLOW,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x43,
diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 41f299d..52244cb 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -59,7 +59,6 @@ static struct s3c2410_uartcfg n30_uartcfgs[] = {
 	/* Normal serial port */
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = 0x2c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
@@ -67,7 +66,6 @@ static struct s3c2410_uartcfg n30_uartcfgs[] = {
 	/* IR port */
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.uart_flags  = UPF_CONS_FLOW,
 		.ucon	     = 0x2c5,
 		.ulcon	     = 0x43,
@@ -77,7 +75,6 @@ static struct s3c2410_uartcfg n30_uartcfgs[] = {
 	 * On the N35 and variants the GPS receiver is connected here. */
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = 0x2c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
diff --git a/arch/arm/mach-s3c2410/mach-otom.c b/arch/arm/mach-s3c2410/mach-otom.c
index d8c7f2e..c9925fc 100644
--- a/arch/arm/mach-s3c2410/mach-otom.c
+++ b/arch/arm/mach-s3c2410/mach-otom.c
@@ -50,14 +50,12 @@ static struct map_desc otom11_iodesc[] __initdata = {
 static struct s3c2410_uartcfg otom11_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
@@ -65,7 +63,6 @@ static struct s3c2410_uartcfg otom11_uartcfgs[] __initdata = {
 	/* port 2 is not actually used */
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index d0e87b6..a8efc13 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -74,21 +74,18 @@ static struct map_desc qt2410_iodesc[] __initdata = {
 static struct s3c2410_uartcfg smdk2410_uartcfgs[] = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2410/mach-smdk2410.c b/arch/arm/mach-s3c2410/mach-smdk2410.c
index 4522230..c3aaa31 100644
--- a/arch/arm/mach-s3c2410/mach-smdk2410.c
+++ b/arch/arm/mach-s3c2410/mach-smdk2410.c
@@ -65,21 +65,18 @@ static struct map_desc smdk2410_iodesc[] __initdata = {
 static struct s3c2410_uartcfg smdk2410_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2410/mach-tct_hammer.c b/arch/arm/mach-s3c2410/mach-tct_hammer.c
index 929164a..78775fd 100644
--- a/arch/arm/mach-s3c2410/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c2410/mach-tct_hammer.c
@@ -103,21 +103,18 @@ static struct map_desc tct_hammer_iodesc[] __initdata = {
 static struct s3c2410_uartcfg tct_hammer_uartcfgs[] = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2410/mach-vr1000.c b/arch/arm/mach-s3c2410/mach-vr1000.c
index d540d79..eafcc5f 100644
--- a/arch/arm/mach-s3c2410/mach-vr1000.c
+++ b/arch/arm/mach-s3c2410/mach-vr1000.c
@@ -129,7 +129,6 @@ static struct s3c24xx_uart_clksrc vr1000_serial_clocks[] = {
 static struct s3c2410_uartcfg vr1000_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
@@ -138,7 +137,6 @@ static struct s3c2410_uartcfg vr1000_uartcfgs[] __initdata = {
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
@@ -148,7 +146,6 @@ static struct s3c2410_uartcfg vr1000_uartcfgs[] __initdata = {
 	/* port 2 is not actually used */
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
index 478f4b4..dfe494e 100644
--- a/arch/arm/mach-s3c2412/mach-jive.c
+++ b/arch/arm/mach-s3c2412/mach-jive.c
@@ -65,21 +65,18 @@ static struct map_desc jive_iodesc[] __initdata = {
 static struct s3c2410_uartcfg jive_uartcfgs[] = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2412/mach-smdk2413.c b/arch/arm/mach-s3c2412/mach-smdk2413.c
index ba93a35..8cc2f9f 100644
--- a/arch/arm/mach-s3c2412/mach-smdk2413.c
+++ b/arch/arm/mach-s3c2412/mach-smdk2413.c
@@ -56,14 +56,12 @@ static struct map_desc smdk2413_iodesc[] __initdata = {
 static struct s3c2410_uartcfg smdk2413_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
@@ -71,7 +69,6 @@ static struct s3c2410_uartcfg smdk2413_uartcfgs[] __initdata = {
 	/* IR port */
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x43,
 		.ufcon	     = 0x51,
diff --git a/arch/arm/mach-s3c2412/mach-vstms.c b/arch/arm/mach-s3c2412/mach-vstms.c
index 3ca9265..9827c89 100644
--- a/arch/arm/mach-s3c2412/mach-vstms.c
+++ b/arch/arm/mach-s3c2412/mach-vstms.c
@@ -55,21 +55,18 @@ static struct map_desc vstms_iodesc[] __initdata = {
 static struct s3c2410_uartcfg vstms_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
index 5fc3f67..912e64e 100644
--- a/arch/arm/mach-s3c2416/mach-smdk2416.c
+++ b/arch/arm/mach-s3c2416/mach-smdk2416.c
@@ -91,14 +91,12 @@ static struct map_desc smdk2416_iodesc[] __initdata = {
 static struct s3c2410_uartcfg smdk2416_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
@@ -106,7 +104,6 @@ static struct s3c2410_uartcfg smdk2416_uartcfgs[] __initdata = {
 	/* IR port */
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON | 0x50,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2440/mach-anubis.c b/arch/arm/mach-s3c2440/mach-anubis.c
index b73f78a..b29a37f 100644
--- a/arch/arm/mach-s3c2440/mach-anubis.c
+++ b/arch/arm/mach-s3c2440/mach-anubis.c
@@ -115,7 +115,6 @@ static struct s3c24xx_uart_clksrc anubis_serial_clocks[] = {
 static struct s3c2410_uartcfg anubis_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
@@ -124,7 +123,6 @@ static struct s3c2410_uartcfg anubis_uartcfgs[] __initdata = {
 	},
 	[1] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index 8472579..6503ce3 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -76,7 +76,6 @@ static struct s3c24xx_uart_clksrc at2440evb_serial_clocks[] = {
 static struct s3c2410_uartcfg at2440evb_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
@@ -85,7 +84,6 @@ static struct s3c2410_uartcfg at2440evb_uartcfgs[] __initdata = {
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 9e39faa..d128f4c 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -128,21 +128,18 @@ static struct map_desc gta02_iodesc[] __initdata = {
 static struct s3c2410_uartcfg gta02_uartcfgs[] = {
 	[0] = {
 		.hwport		= 0,
-		.flags		= 0,
 		.ucon		= UCON,
 		.ulcon		= ULCON,
 		.ufcon		= UFCON,
 	},
 	[1] = {
 		.hwport		= 1,
-		.flags		= 0,
 		.ucon		= UCON,
 		.ulcon		= ULCON,
 		.ufcon		= UFCON,
 	},
 	[2] = {
 		.hwport		= 2,
-		.flags		= 0,
 		.ucon		= UCON,
 		.ulcon		= ULCON,
 		.ufcon		= UFCON,
diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index a76bcda..61d2bf0 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -74,21 +74,18 @@ static struct map_desc mini2440_iodesc[] __initdata = {
 static struct s3c2410_uartcfg mini2440_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2440/mach-nexcoder.c b/arch/arm/mach-s3c2440/mach-nexcoder.c
index 3ff62de..727862c 100644
--- a/arch/arm/mach-s3c2440/mach-nexcoder.c
+++ b/arch/arm/mach-s3c2440/mach-nexcoder.c
@@ -58,21 +58,18 @@ static struct map_desc nexcoder_iodesc[] __initdata = {
 static struct s3c2410_uartcfg nexcoder_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2440/mach-osiris.c b/arch/arm/mach-s3c2440/mach-osiris.c
index 319458d..0a4af5b 100644
--- a/arch/arm/mach-s3c2440/mach-osiris.c
+++ b/arch/arm/mach-s3c2440/mach-osiris.c
@@ -118,7 +118,6 @@ static struct s3c24xx_uart_clksrc osiris_serial_clocks[] = {
 static struct s3c2410_uartcfg osiris_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
@@ -127,7 +126,6 @@ static struct s3c2410_uartcfg osiris_uartcfgs[] __initdata = {
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
@@ -136,7 +134,6 @@ static struct s3c2410_uartcfg osiris_uartcfgs[] __initdata = {
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 8603b57..a144861 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -72,7 +72,6 @@ static struct s3c24xx_uart_clksrc rx1950_serial_clocks[] = {
 static struct s3c2410_uartcfg rx1950_uartcfgs[] __initdata = {
 	[0] = {
 	       .hwport = 0,
-	       .flags = 0,
 	       .ucon = 0x3c5,
 	       .ulcon = 0x03,
 	       .ufcon = 0x51,
@@ -81,7 +80,6 @@ static struct s3c2410_uartcfg rx1950_uartcfgs[] __initdata = {
 	},
 	[1] = {
 	       .hwport = 1,
-	       .flags = 0,
 	       .ucon = 0x3c5,
 	       .ulcon = 0x03,
 	       .ufcon = 0x51,
@@ -91,7 +89,6 @@ static struct s3c2410_uartcfg rx1950_uartcfgs[] __initdata = {
 	/* IR port */
 	[2] = {
 	       .hwport = 2,
-	       .flags = 0,
 	       .ucon = 0x3c5,
 	       .ulcon = 0x43,
 	       .ufcon = 0xf1,
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index d2946de..a31961f 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -79,7 +79,6 @@ static struct s3c24xx_uart_clksrc rx3715_serial_clocks[] = {
 static struct s3c2410_uartcfg rx3715_uartcfgs[] = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
@@ -88,7 +87,6 @@ static struct s3c2410_uartcfg rx3715_uartcfgs[] = {
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x00,
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index df83276..b6c9de1 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -80,14 +80,12 @@ static struct map_desc smdk2440_iodesc[] __initdata = {
 static struct s3c2410_uartcfg smdk2440_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
@@ -95,7 +93,6 @@ static struct s3c2410_uartcfg smdk2440_uartcfgs[] __initdata = {
 	/* IR port */
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x43,
 		.ufcon	     = 0x51,
diff --git a/arch/arm/mach-s3c2443/mach-smdk2443.c b/arch/arm/mach-s3c2443/mach-smdk2443.c
index 4c863d3..a1c1de0 100644
--- a/arch/arm/mach-s3c2443/mach-smdk2443.c
+++ b/arch/arm/mach-s3c2443/mach-smdk2443.c
@@ -80,14 +80,12 @@ static struct map_desc smdk2443_iodesc[] __initdata = {
 static struct s3c2410_uartcfg smdk2443_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
@@ -95,7 +93,6 @@ static struct s3c2410_uartcfg smdk2443_uartcfgs[] __initdata = {
 	/* IR port */
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x43,
 		.ufcon	     = 0x51,
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 4a0bb24..baa91a1 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -69,14 +69,12 @@ static __u32 anw6410_extdev_status;
 static struct s3c2410_uartcfg anw6410_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 187441a..4790294 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -50,21 +50,18 @@
 static struct s3c2410_uartcfg hmt_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index bf65747..7b9d86e 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -53,21 +53,18 @@ static struct s3c2410_uartcfg ncp_uartcfgs[] __initdata = {
 	/* REVISIT: NCP uses only serial 1, 2 */
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 028d080..e772890 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -46,21 +46,18 @@
 static struct s3c2410_uartcfg smartq_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 5991667..15269ae 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -44,14 +44,12 @@
 static struct s3c2410_uartcfg smdk6400_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index d9a0355..2e7b261 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -74,28 +74,24 @@
 static struct s3c2410_uartcfg smdk6410_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
 	},
 	[3] = {
 		.hwport	     = 3,
-		.flags	     = 0,
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
index 8291fec..f93c8c5 100644
--- a/arch/arm/mach-s5p6440/mach-smdk6440.c
+++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
@@ -57,28 +57,24 @@
 static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = S5P6440_UCON_DEFAULT,
 		.ulcon	     = S5P6440_ULCON_DEFAULT,
 		.ufcon	     = S5P6440_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = S5P6440_UCON_DEFAULT,
 		.ulcon	     = S5P6440_ULCON_DEFAULT,
 		.ufcon	     = S5P6440_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = S5P6440_UCON_DEFAULT,
 		.ulcon	     = S5P6440_ULCON_DEFAULT,
 		.ufcon	     = S5P6440_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport	     = 3,
-		.flags	     = 0,
 		.ucon	     = S5P6440_UCON_DEFAULT,
 		.ulcon	     = S5P6440_ULCON_DEFAULT,
 		.ufcon	     = S5P6440_UFCON_DEFAULT,
diff --git a/arch/arm/mach-s5p6442/mach-smdk6442.c b/arch/arm/mach-s5p6442/mach-smdk6442.c
index ebcf997..dc0fa72 100644
--- a/arch/arm/mach-s5p6442/mach-smdk6442.c
+++ b/arch/arm/mach-s5p6442/mach-smdk6442.c
@@ -43,21 +43,18 @@
 static struct s3c2410_uartcfg smdk6442_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
-		.flags		= 0,
 		.ucon		= S5P6442_UCON_DEFAULT,
 		.ulcon		= S5P6442_ULCON_DEFAULT,
 		.ufcon		= S5P6442_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
-		.flags		= 0,
 		.ucon		= S5P6442_UCON_DEFAULT,
 		.ulcon		= S5P6442_ULCON_DEFAULT,
 		.ufcon		= S5P6442_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
-		.flags		= 0,
 		.ucon		= S5P6442_UCON_DEFAULT,
 		.ulcon		= S5P6442_ULCON_DEFAULT,
 		.ufcon		= S5P6442_UFCON_DEFAULT,
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index af22f82..1698d03 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -60,28 +60,24 @@
 static struct s3c2410_uartcfg smdkc100_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = S5PC100_UCON_DEFAULT,
 		.ulcon	     = S5PC100_ULCON_DEFAULT,
 		.ufcon	     = S5PC100_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = S5PC100_UCON_DEFAULT,
 		.ulcon	     = S5PC100_ULCON_DEFAULT,
 		.ufcon	     = S5PC100_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = S5PC100_UCON_DEFAULT,
 		.ulcon	     = S5PC100_ULCON_DEFAULT,
 		.ufcon	     = S5PC100_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport	     = 3,
-		.flags	     = 0,
 		.ucon	     = S5PC100_UCON_DEFAULT,
 		.ulcon	     = S5PC100_ULCON_DEFAULT,
 		.ufcon	     = S5PC100_UFCON_DEFAULT,
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 10bc76e..37a62dd 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -46,28 +46,24 @@
 static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport		= 3,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 4863b13..b0e54ea 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -43,28 +43,24 @@
 static struct s3c2410_uartcfg goni_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport		= 3,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 4c8903c..1410a5f 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -43,28 +43,24 @@
 static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport		= 3,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 0d46279..e0d72fc 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -45,28 +45,24 @@
 static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport		= 3,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index a6eba84..24c1e92 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -256,7 +256,6 @@ struct s3c24xx_uart_clksrc {
 struct s3c2410_uartcfg {
 	unsigned char	   hwport;	 /* hardware port number */
 	unsigned char	   unused;
-	unsigned short	   flags;
 	upf_t		   uart_flags;	 /* default uart flags */
 
 	unsigned long	   ucon;	 /* value of ucon for port */
-- 
1.7.0.4
