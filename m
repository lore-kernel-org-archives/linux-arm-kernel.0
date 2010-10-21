From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 21 Oct 2010 21:05:25 +0200
Subject: [PATCH] spi/pl022: fix erroneous platform data in U300
Message-ID: <1287687925-27189-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes an erroneous use of LSB first in the U300 machine, the
PL022 used in U300 is a standard ARM core that doesn't support this
bit so it should never have been set.

Cc: Kevin Wells <wellsk40@gmail.com>OA
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-u300/spi.c b/arch/arm/mach-u300/spi.c
index 779abf7..5767208 100644
--- a/arch/arm/mach-u300/spi.c
+++ b/arch/arm/mach-u300/spi.c
@@ -67,7 +67,7 @@ static struct spi_board_info u300_spi_devices[] = {
 		.bus_num        = 0, /* Only one bus on this chip */
 		.chip_select    = 0,
 		/* Means SPI_CS_HIGH, change if e.g low CS */
-		.mode           = SPI_MODE_1 | SPI_LSB_FIRST | SPI_LOOP,
+		.mode           = SPI_MODE_1 | SPI_LOOP,
 	},
 #endif
 };
-- 
1.6.3.3
