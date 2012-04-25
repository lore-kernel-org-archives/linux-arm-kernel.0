From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:23 +0530
Subject: [PATCH 13/33] ARM: S3C24XX: mach-h1940: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-14-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c24xx/mach-h1940.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index 6b21ba1..bb8d008 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -253,13 +253,8 @@ static struct pda_power_pdata power_supply_info = {
 };
 
 static struct resource power_supply_resources[] = {
-	[0] = {
-			.name	= "ac",
-			.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE |
-					  IORESOURCE_IRQ_HIGHEDGE,
-			.start	= IRQ_EINT2,
-			.end	= IRQ_EINT2,
-	},
+	[0] = DEFINE_RES_NAMED(IRQ_EINT2, 1, "ac", IORESOURCE_IRQ \
+			| IORESOURCE_IRQ_LOWEDGE | IORESOURCE_IRQ_HIGHEDGE),
 };
 
 static struct platform_device power_supply = {
-- 
1.7.4.1
