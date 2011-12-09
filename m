From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri,  9 Dec 2011 20:55:03 +0800
Subject: [PATCH] i2c: i2c-s3c2410: Add a cpu_relax() to busy wait for bus idle
Message-ID: <1323435303-17040-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Be a bit more friendly.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/i2c/busses/i2c-s3c2410.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 065c316..acda56e1 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -535,6 +535,7 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 
 	/* first, try busy waiting briefly */
 	do {
+		cpu_relax();
 		iicstat = readl(i2c->regs + S3C2410_IICSTAT);
 	} while ((iicstat & S3C2410_IICSTAT_START) && --spins);
 
-- 
1.7.7.3
