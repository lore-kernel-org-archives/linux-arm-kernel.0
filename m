From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Mar 2012 04:21:21 +0000
Subject: [PATCH 1/9] ARM: orion: spi: remove enable_clock_fix which is not used
In-Reply-To: <cover.1331868507.git.jason@lakedaemon.net>
References: <cover.1331868507.git.jason@lakedaemon.net>
Message-ID: <eefe66c948eeb87f67f28ff162ad905de273a650.1331868507.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/spi-orion.c       |    5 -----
 include/linux/spi/orion_spi.h |    1 -
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 13448c8..e496f79 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -359,11 +359,6 @@ static int orion_spi_setup(struct spi_device *spi)
 
 	orion_spi = spi_master_get_devdata(spi->master);
 
-	/* Fix ac timing if required.   */
-	if (orion_spi->spi_info->enable_clock_fix)
-		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
-				  (1 << 14));
-
 	if ((spi->max_speed_hz == 0)
 			|| (spi->max_speed_hz > orion_spi->max_speed))
 		spi->max_speed_hz = orion_spi->max_speed;
diff --git a/include/linux/spi/orion_spi.h b/include/linux/spi/orion_spi.h
index decf6d8..b4d9fa6 100644
--- a/include/linux/spi/orion_spi.h
+++ b/include/linux/spi/orion_spi.h
@@ -11,7 +11,6 @@
 
 struct orion_spi_info {
 	u32	tclk;		/* no <linux/clk.h> support yet */
-	u32	enable_clock_fix;
 };
 
 
-- 
1.7.3.4
