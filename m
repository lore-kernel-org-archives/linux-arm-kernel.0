From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Oct 2009 18:17:58 +0100
Subject: [PATCH 3/4] S3C64XX: Set rate of crystal mux
In-Reply-To: <1256145479-27952-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1256145479-27952-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1256145479-27952-3-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code assumes that the external clock mux will be set to
the crystal. Set this up explicitly within the clock API.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 9745852..6ffa21e 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -677,6 +677,9 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
 
 	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
 
+	/* For now assume the mux always selects the crystal */
+	clk_ext_xtal_mux.parent = xtal_clk;
+
 	epll = s3c6400_get_epll(xtal);
 	mpll = s3c6400_get_pll(xtal, __raw_readl(S3C_MPLL_CON));
 	apll = s3c6400_get_pll(xtal, __raw_readl(S3C_APLL_CON));
-- 
1.6.5
