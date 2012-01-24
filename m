From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 Jan 2012 21:31:44 +0000
Subject: [PATCH 2/4] ARM: S3C64XX: Define some additional always off clocks
In-Reply-To: <1327440706-31915-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20120124213127.GH1135@opensource.wolfsonmicro.com>
 <1327440706-31915-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1327440706-31915-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entries to clocks_off for some additional clocks which are not
currently used by any mainline drivers. They default on at power up
but are never actually used so

If these blocks are actually supported some of these bindings would need
to be redone properly, for example hooking up to the muxes that use them,
but that can be done incrementally.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/clock.c |  101 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index b58274f..63f2c8a 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -220,6 +220,107 @@ static struct clk init_clocks_off[] = {
 		.parent		= &clk_h,
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_DMA1,
+	}, {
+		.name		= "3dse",
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_3DSE,
+	}, {
+		.name		= "hclk_secur",
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_SECUR,
+	}, {
+		.name		= "sdma1",
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_SDMA1,
+	}, {
+		.name		= "sdma0",
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_SDMA0,
+	}, {
+		.name		= "hclk_jpeg",
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_JPEG,
+	}, {
+		.name		= "camif",
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_CAMIF,
+	}, {
+		.name		= "hclk_scaler",
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_SCALER,
+	}, {
+		.name		= "2d",
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_2D,
+	}, {
+		.name		= "tv",
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_TV,
+	}, {
+		.name		= "post0",
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_POST0,
+	}, {
+		.name		= "rot",
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_ROT,
+	}, {
+		.name		= "hclk_mfc",
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_MFC,
+	}, {
+		.name		= "pclk_mfc",
+		.parent		= &clk_p,
+		.enable		= s3c64xx_pclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_PCLK_MFC,
+	}, {
+		.name		= "dac27",
+		.enable		= s3c64xx_sclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_SCLK_DAC27,
+	}, {
+		.name		= "tv27",
+		.enable		= s3c64xx_sclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_SCLK_TV27,
+	}, {
+		.name		= "scaler27",
+		.enable		= s3c64xx_sclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_SCLK_SCALER27,
+	}, {
+		.name		= "sclk_scaler",
+		.enable		= s3c64xx_sclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_SCLK_SCALER,
+	}, {
+		.name		= "post0_27",
+		.enable		= s3c64xx_sclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_SCLK_POST0_27,
+	}, {
+		.name		= "secur",
+		.enable		= s3c64xx_sclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_SCLK_SECUR,
+	}, {
+		.name		= "sclk_mfc",
+		.enable		= s3c64xx_sclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_SCLK_MFC,
+	}, {
+		.name		= "cam",
+		.enable		= s3c64xx_sclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_SCLK_CAM,
+	}, {
+		.name		= "sclk_jpeg",
+		.enable		= s3c64xx_sclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_SCLK_JPEG,
 	},
 };
 
-- 
1.7.9.rc1
