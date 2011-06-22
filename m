From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 22 Jun 2011 09:25:28 -0300
Subject: [PATCH v2 6/6] ARM: mach-imx/mx27_3ds: Do not annotate the chip
	select as internal
In-Reply-To: <1308745528-22089-5-git-send-email-fabio.estevam@freescale.com>
References: <1308745528-22089-1-git-send-email-fabio.estevam@freescale.com>
	<1308745528-22089-2-git-send-email-fabio.estevam@freescale.com>
	<1308745528-22089-3-git-send-email-fabio.estevam@freescale.com>
	<1308745528-22089-4-git-send-email-fabio.estevam@freescale.com>
	<1308745528-22089-5-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1308745528-22089-6-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the i.MX SPI driver the chipselect pins can be of the following types:

- internal: when the chipselect pin is used as a dedicated CS pin of the CSPI controller
- GPIO: a generic GPIO can be used as a chipselect funtion

On the mx27_3ds the SPI2 chip select is a GPIO, so don't annotate 'internal' in the chip select
definition. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Rebased on Sascha's for-next branch

 arch/arm/mach-imx/mach-mx27_3ds.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index e6d811d..85f56eb 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -304,11 +304,11 @@ static const struct spi_imx_master spi1_pdata __initconst = {
 	.num_chipselect	= ARRAY_SIZE(spi1_chipselect),
 };
 
-static int spi2_internal_chipselect[] = {SPI2_SS0};
+static int spi2_chipselect[] = {SPI2_SS0};
 
 static const struct spi_imx_master spi2_pdata __initconst = {
-	.chipselect	= spi2_internal_chipselect,
-	.num_chipselect	= ARRAY_SIZE(spi2_internal_chipselect),
+	.chipselect	= spi2_chipselect,
+	.num_chipselect	= ARRAY_SIZE(spi2_chipselect),
 };
 
 static struct imx_fb_videomode mx27_3ds_modes[] = {
-- 
1.6.0.4
