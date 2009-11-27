From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Nov 2009 16:43:56 +0000
Subject: [PATCH 4/7] S3C64XX: Declare IISv4 PCLK for S3C6410
In-Reply-To: <20091127164312.GA11913@rakim.wolfsonmicro.main>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
Message-ID: <1259340239-12067-4-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi <jassi.brar@samsung.com>

[Updated the device ID to -1 since there's only one IISv4 device but the
S3C clock API tries to match based on the ID of the requesting device
(and not the name) -- broonie.]

Signed-Off-by: Jassi <jassi.brar@samsung.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-s3c64xx/clock.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/clock.c b/arch/arm/plat-s3c64xx/clock.c
index 7a36e89..2f1548e 100644
--- a/arch/arm/plat-s3c64xx/clock.c
+++ b/arch/arm/plat-s3c64xx/clock.c
@@ -129,6 +129,14 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_IIS1,
 	}, {
+#ifdef CONFIG_CPU_S3C6410
+		.name		= "iis",
+		.id		= -1,  /* There's only one IISv4 port */
+		.parent		= &clk_p,
+		.enable		= s3c64xx_pclk_ctrl,
+		.ctrlbit	= S3C6410_CLKCON_PCLK_IIS2,
+	}, {
+#endif
 		.name		= "spi",
 		.id		= 0,
 		.parent		= &clk_p,
-- 
1.6.5.3
