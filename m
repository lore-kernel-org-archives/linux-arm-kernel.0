From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 07:19:11 +0100
Subject: [PATCH 1/9] ARM: SAMSUNG: Default s3c_device_i2c1
In-Reply-To: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
References: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275027559-29278-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no current SoCs where i2c1 is anything other than an s3c2440-i2c
implementation, so change the device's name to be s3c2440-i2c so we can
go and eliminate the calls in the cpu-init which set the name.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/dev-i2c1.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-i2c1.c b/arch/arm/plat-samsung/dev-i2c1.c
index 858ee2a..f97905f 100644
--- a/arch/arm/plat-samsung/dev-i2c1.c
+++ b/arch/arm/plat-samsung/dev-i2c1.c
@@ -38,7 +38,8 @@ static struct resource s3c_i2c_resource[] = {
 };
 
 struct platform_device s3c_device_i2c1 = {
-	.name		  = "s3c2410-i2c",
+	/* default to s3c2440-i2c as no SoC with >1 I2C is s3c2410 style */
+	.name		  = "s3c2440-i2c",
 	.id		  = 1,
 	.num_resources	  = ARRAY_SIZE(s3c_i2c_resource),
 	.resource	  = s3c_i2c_resource,
-- 
1.6.3.3
