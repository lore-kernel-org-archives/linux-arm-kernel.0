From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu,  3 Mar 2011 14:58:31 +0000
Subject: [PATCH 3/7] ARM: S3C64XX: Add clock for i2c1
In-Reply-To: <20110303145710.GA32234@opensource.wolfsonmicro.com>
References: <20110303145710.GA32234@opensource.wolfsonmicro.com>
Message-ID: <1299164315-22246-3-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

The clock for i2c1 has been missing for a while, add it to the list of
clocks for the system and ensure it is initialised at startup.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/clock.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index dd37820..fdfc4d5 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -151,6 +151,12 @@ static struct clk init_clocks_off[] = {
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_IIC,
 	}, {
+		.name		= "i2c",
+		.id		= 1,
+		.parent		= &clk_p,
+		.enable		= s3c64xx_pclk_ctrl,
+		.ctrlbit	= S3C6410_CLKCON_PCLK_I2C1,
+	}, {
 		.name		= "iis",
 		.id		= 0,
 		.parent		= &clk_p,
-- 
1.7.2.3
