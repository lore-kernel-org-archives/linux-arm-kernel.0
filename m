From: augulis.darius@gmail.com (Darius Augulis)
Date: Mon, 16 Aug 2010 20:43:25 +0300
Subject: [PATCH 1/2] s3c: mach-real6410: fix coding style errors
In-Reply-To: <20100816173905.14924.62664.stgit@darius-desktop>
References: <20100816173905.14924.62664.stgit@darius-desktop>
Message-ID: <20100816174325.14924.76162.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix errors reported by checkpatch.pl script

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-real6410.c |  104 +++++++++++++++++----------------
 1 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 5c07d01..9f79e6b 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -30,73 +30,73 @@
 #include <plat/devs.h>
 #include <plat/regs-serial.h>
 
-#define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
-#define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
-#define UFCON S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE
+#define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
+#define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
+#define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
 
 static struct s3c2410_uartcfg real6410_uartcfgs[] __initdata = {
 	[0] = {
-		.hwport	     = 0,
-		.flags	     = 0,
-		.ucon	     = UCON,
-		.ulcon	     = ULCON,
-		.ufcon	     = UFCON,
+		.hwport	= 0,
+		.flags	= 0,
+		.ucon	= UCON,
+		.ulcon	= ULCON,
+		.ufcon	= UFCON,
 	},
 	[1] = {
-		.hwport	     = 1,
-		.flags	     = 0,
-		.ucon	     = UCON,
-		.ulcon	     = ULCON,
-		.ufcon	     = UFCON,
+		.hwport	= 1,
+		.flags	= 0,
+		.ucon	= UCON,
+		.ulcon	= ULCON,
+		.ufcon	= UFCON,
 	},
 	[2] = {
-		.hwport	     = 2,
-		.flags	     = 0,
-		.ucon	     = UCON,
-		.ulcon	     = ULCON,
-		.ufcon	     = UFCON,
+		.hwport	= 2,
+		.flags	= 0,
+		.ucon	= UCON,
+		.ulcon	= ULCON,
+		.ufcon	= UFCON,
 	},
 	[3] = {
-		.hwport	     = 3,
-		.flags	     = 0,
-		.ucon	     = UCON,
-		.ulcon	     = ULCON,
-		.ufcon	     = UFCON,
+		.hwport	= 3,
+		.flags	= 0,
+		.ucon	= UCON,
+		.ulcon	= ULCON,
+		.ufcon	= UFCON,
 	},
 };
 
 /* DM9000AEP 10/100 ethernet controller */
 
 static struct resource real6410_dm9k_resource[] = {
-        [0] = {
-                .start = S3C64XX_PA_XM0CSN1,
-                .end   = S3C64XX_PA_XM0CSN1 + 1,
-                .flags = IORESOURCE_MEM
-        },
-        [1] = {
-                .start = S3C64XX_PA_XM0CSN1 + 4,
-                .end   = S3C64XX_PA_XM0CSN1 + 5,
-                .flags = IORESOURCE_MEM
-        },
-        [2] = {
-                .start = S3C_EINT(7),
-                .end   = S3C_EINT(7),
-                .flags = IORESOURCE_IRQ,
-        }
+	[0] = {
+		.start	= S3C64XX_PA_XM0CSN1,
+		.end	= S3C64XX_PA_XM0CSN1 + 1,
+		.flags	= IORESOURCE_MEM
+	},
+	[1] = {
+		.start	= S3C64XX_PA_XM0CSN1 + 4,
+		.end	= S3C64XX_PA_XM0CSN1 + 5,
+		.flags	= IORESOURCE_MEM
+	},
+	[2] = {
+		.start	= S3C_EINT(7),
+		.end	= S3C_EINT(7),
+		.flags	= IORESOURCE_IRQ,
+	}
 };
 
 static struct dm9000_plat_data real6410_dm9k_pdata = {
-        .flags          = (DM9000_PLATF_16BITONLY | DM9000_PLATF_NO_EEPROM),
+	.flags		= (DM9000_PLATF_16BITONLY | DM9000_PLATF_NO_EEPROM),
 };
 
 static struct platform_device real6410_device_eth = {
-        .name           = "dm9000",
-        .id             = -1,
-        .num_resources  = ARRAY_SIZE(real6410_dm9k_resource),
-        .resource       = real6410_dm9k_resource,
-        .dev            = {
-                .platform_data  = &real6410_dm9k_pdata,
-        },
+	.name		= "dm9000",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(real6410_dm9k_resource),
+	.resource	= real6410_dm9k_resource,
+	.dev		= {
+		.platform_data	= &real6410_dm9k_pdata,
+	},
 };
 
 static struct platform_device *real6410_devices[] __initdata = {
@@ -129,12 +129,12 @@ static void __init real6410_machine_init(void)
 	/* set timing for nCS1 suitable for ethernet chip */
 
 	__raw_writel((0 << S3C64XX_SROM_BCX__PMC__SHIFT) |
-			(6 << S3C64XX_SROM_BCX__TACP__SHIFT) |
-			(4 << S3C64XX_SROM_BCX__TCAH__SHIFT) |
-			(1 << S3C64XX_SROM_BCX__TCOH__SHIFT) |
-			(13 << S3C64XX_SROM_BCX__TACC__SHIFT) |
-			(4 << S3C64XX_SROM_BCX__TCOS__SHIFT) |
-			(0 << S3C64XX_SROM_BCX__TACS__SHIFT), S3C64XX_SROM_BC1);
+		(6 << S3C64XX_SROM_BCX__TACP__SHIFT) |
+		(4 << S3C64XX_SROM_BCX__TCAH__SHIFT) |
+		(1 << S3C64XX_SROM_BCX__TCOH__SHIFT) |
+		(13 << S3C64XX_SROM_BCX__TACC__SHIFT) |
+		(4 << S3C64XX_SROM_BCX__TCOS__SHIFT) |
+		(0 << S3C64XX_SROM_BCX__TACS__SHIFT), S3C64XX_SROM_BC1);
 
 	platform_add_devices(real6410_devices, ARRAY_SIZE(real6410_devices));
 }
