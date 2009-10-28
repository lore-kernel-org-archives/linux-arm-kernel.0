From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 12:15:43 +0000
Subject: [PATCH 02/12] ARM: S3C24XX: Introduce S3C2442B CPU
In-Reply-To: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
References: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1256732153-22027-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Harald Welte <laforge@gnumonks.org>

Add the S3C2442B CPU ID to aid support the Openmoko GTA02 / Freerunner.

Signed-off-by: Harald Welte <laforge@gnumonks.org>
Signed-off-by: Andy Green <andy@warmcat.com>
Signed-off-by: Nelson Castillo <arhuaco@freaks-unidos.net>
[ben-linux at fluff.org: edit description for clarity and S3C2442B as uppercase]
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c24xx/cpu.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 5447e60..4af9dd9 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -61,6 +61,7 @@ static const char name_s3c2410[]  = "S3C2410";
 static const char name_s3c2412[]  = "S3C2412";
 static const char name_s3c2440[]  = "S3C2440";
 static const char name_s3c2442[]  = "S3C2442";
+static const char name_s3c2442b[]  = "S3C2442B";
 static const char name_s3c2443[]  = "S3C2443";
 static const char name_s3c2410a[] = "S3C2410A";
 static const char name_s3c2440a[] = "S3C2440A";
@@ -112,6 +113,15 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.name		= name_s3c2442
 	},
 	{
+		.idcode		= 0x32440aab,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c244x_map_io,
+		.init_clocks	= s3c244x_init_clocks,
+		.init_uarts	= s3c244x_init_uarts,
+		.init		= s3c2442_init,
+		.name		= name_s3c2442b
+	},
+	{
 		.idcode		= 0x32412001,
 		.idmask		= 0xffffffff,
 		.map_io		= s3c2412_map_io,
-- 
1.6.3.3
