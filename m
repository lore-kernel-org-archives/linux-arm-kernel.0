From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:55:37 +0900
Subject: [PATCH 03/12] ARM: S3C24XX: Remove extern declaration of clk_msysclk
In-Reply-To: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329346545-16373-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko@sntech.de>

clk_msysclk is not needed outside of s3c2443-clock.c.

Removing the extern declaration will prevent conflicts with the
s3c2412 clk_msysclk in the following cleanups.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
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
1.7.4.4
