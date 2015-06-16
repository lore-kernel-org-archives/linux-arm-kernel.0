From: hsweeten@visionengravers.com (H Hartley Sweeten)
Date: Tue, 16 Jun 2015 09:50:29 -0700
Subject: [PATCH 1/2] ARM: ep93xx: vision_ep9307: enable DMA for SPI
Message-ID: <1434473429-5208-1-git-send-email-hsweeten@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the 'use_dma' flag in the SPI platform data to improve the speed
of the mmc_spi driver.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
---
 arch/arm/mach-ep93xx/vision_ep9307.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index 6bc1c18..aa87dfa 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -281,7 +281,8 @@ static struct spi_board_info vision_spi_board_info[] __initdata = {
 };
 
 static struct ep93xx_spi_info vision_spi_master __initdata = {
-	.num_chipselect		= ARRAY_SIZE(vision_spi_board_info),
+	.num_chipselect	= ARRAY_SIZE(vision_spi_board_info),
+	.use_dma	= 1,
 };
 
 /*************************************************************************
-- 
2.3.0
