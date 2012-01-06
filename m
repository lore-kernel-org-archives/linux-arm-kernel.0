From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 7 Jan 2012 00:23:50 +0100
Subject: [PATCH 1/8] S3C24XX: Remove extern declaration of clk_msysclk
In-Reply-To: <201201070022.40431.heiko@sntech.de>
References: <201201070022.40431.heiko@sntech.de>
Message-ID: <201201070023.51657.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_msysclk is not needed outside of s3c2443-clock.c.

Removing the extern declaration will prevent conflicts with the
s3c2412 clk_msysclk in the following cleanups.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-samsung/include/plat/s3c2443.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/s3c2443.h b/arch/arm/plat-samsung/include/plat/s3c2443.h
index dce05b4..ffaecb9 100644
--- a/arch/arm/plat-samsung/include/plat/s3c2443.h
+++ b/arch/arm/plat-samsung/include/plat/s3c2443.h
@@ -51,4 +51,3 @@ extern int s3c2443_clkcon_enable_s(struct clk *clk, int enable);
 
 extern struct clksrc_clk clk_epllref;
 extern struct clksrc_clk clk_esysclk;
-extern struct clksrc_clk clk_msysclk;
-- 
1.7.5.4
