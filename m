From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon,  3 Mar 2014 17:02:11 +0100
Subject: [PATCH v2 06/11] ARM: s3c64xx: pm: Add pwr_stat bit for domain G
In-Reply-To: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1393862536-9842-7-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a status bit for domain G present in BLK_PWR_STAT register, but
it is currently not specified in the driver.

This patch adds the status bit of domain G to structure describing it.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index c930245..b422eed 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -147,6 +147,7 @@ static struct s3c64xx_pm_domain s3c64xx_pm_i = {
 
 static struct s3c64xx_pm_domain s3c64xx_pm_g = {
 	.ena = S3C64XX_NORMALCFG_DOMAIN_G_ON,
+	.pwr_stat = S3C64XX_BLKPWRSTAT_G,
 	.pd = {
 		.name = "G",
 		.power_off = s3c64xx_pd_off,
-- 
1.9.0
