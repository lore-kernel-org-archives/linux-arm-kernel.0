From: andy@warmcat.com (Andy Green)
Date: Tue, 29 Dec 2009 14:40:43 +0000
Subject: [PATCH 4/4] smdk6410-comment-ethernet-prerequisites.patch
In-Reply-To: <20091229143756.15524.25160.stgit@hit-nxdomain.opendns.com>
References: <20091229143756.15524.25160.stgit@hit-nxdomain.opendns.com>
Message-ID: <20091229144042.15524.35906.stgit@hit-nxdomain.opendns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LAN9115 Ethernet only works on SMDK6410 if certain switches
are set in specific ways.  Document the requirement.

Signed-off-by: Andy Green <andy@warmcat.com>
---

 arch/arm/mach-s3c6410/mach-smdk6410.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index d613932..c70661d 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -155,6 +155,16 @@ static struct s3c_fb_platdata smdk6410_lcd_pdata __initdata = {
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
 };
 
+/*
+ * Configuring Ethernet on SMDK6410
+ *
+ * Both CS8900A and LAN9115 chips share one chip select mediated by CFG6.
+ * The constant address below corresponds to nCS1
+ *
+ *  1) Set CFGB2 p3 ON others off, no other CFGB selects "ethernet"
+ *  2) CFG6 needs to be switched to "LAN9115" side
+ */
+
 static struct resource smdk6410_smsc911x_resources[] = {
 	[0] = {
 		.start = S3C64XX_PA_XM0CSN1,
