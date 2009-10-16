From: jbe@pengutronix.de (Juergen Beisert)
Date: Fri, 16 Oct 2009 11:24:50 +0200
Subject: [PATCH] S3C2440: SD-Card usage fails with attribute __initdata for
	the platformdata
In-Reply-To: <20091016054856.GB2261@trinity.fluff.org>
References: <200910152014.50677.jbe@pengutronix.de>
	<20091016054856.GB2261@trinity.fluff.org>
Message-ID: <200910161124.51537.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Author: Juergen Beisert <j.beisert@pengutronix.de>
Subject: Do not use __initdata for MMC's platform data

With __initdata for MMC's platform data the kernel fails at various locations
when using the MMC/SD cards

Signed-off-by: Juergen Beisert <j.beisert@pengutronix.de>

---

diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index ec71a69..f307666 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -233,7 +233,7 @@ struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
 
 /* MMC/SD  */
 
-static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
+static struct s3c24xx_mci_pdata mini2440_mmc_cfg = {
    .gpio_detect   = S3C2410_GPG(8),
    .gpio_wprotect = S3C2410_GPH(8),
    .set_power     = NULL,
