From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 20 Aug 2011 18:03:59 +0200
Subject: [PATCH 4/4] S3C2443: Add hsspi-clock from pclk
In-Reply-To: <201108201757.56483.heiko@sntech.de>
References: <201108201757.56483.heiko@sntech.de>
Message-ID: <201108201803.59832.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock is common to S3C2443/2416/2450.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-s3c24xx/s3c2443-clock.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index e2807d9..92fc25b 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -259,6 +259,11 @@ static struct clk init_clocks_off[] = {
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_IIS,
 	}, {
+		.name		= "hsspi",
+		.parent		= &clk_p,
+		.enable		= s3c2443_clkcon_enable_p,
+		.ctrlbit	= S3C2443_PCLKCON_HSSPI,
+	}, {
 		.name		= "adc",
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
-- 
1.7.2.3
