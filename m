From: jassi.brar@samsung.com (Jassi)
Date: Wed, 16 Sep 2009 16:25:29 +0900
Subject: [PATCH] S3C64XX CLOCK: Init ext_xtal_mux rate
Message-ID: <1253085929-6621-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize rate for the clk_ext_xtal_mux, even though the parent
isn't specified.
Ideally, init_clocks should set this mux and all PLLs read their
input clock freqs from clk_ext_xtal_mux.rate.

Signed-off-by: Jassi <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 1debc1f..de26f48 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -694,6 +694,7 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
 	clk_fout_mpll.rate = mpll;
 	clk_fout_epll.rate = epll;
 	clk_fout_apll.rate = apll;
+	clk_ext_xtal_mux.rate = xtal;
 
 	clk_h2.rate = hclk2;
 	clk_h.rate = hclk;
-- 
1.6.2.5
