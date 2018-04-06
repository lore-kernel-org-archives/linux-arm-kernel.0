From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 6 Apr 2018 08:39:32 +0200
Subject: [PATCH 5/6] clk: stm32mp1: set stgen_k clock as critical
In-Reply-To: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
References: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1522996773-24129-6-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

stgen_k should be declared as critical to avoid blocking console
when ck_hsi is not used.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index e32fc23..b7b5361 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1913,8 +1913,7 @@ enum {
 	KCLK(RNG1_K, "rng1_k", rng_src, 0, G_RNG1, M_RNG1),
 	KCLK(RNG2_K, "rng2_k", rng_src, 0, G_RNG2, M_RNG2),
 	KCLK(USBPHY_K, "usbphy_k", usbphy_src, 0, G_USBPHY, M_USBPHY),
-	KCLK(STGEN_K, "stgen_k",  stgen_src, CLK_IGNORE_UNUSED,
-	     G_STGEN, M_STGEN),
+	KCLK(STGEN_K, "stgen_k", stgen_src, CLK_IS_CRITICAL, G_STGEN, M_STGEN),
 	KCLK(SPDIF_K, "spdif_k", spdif_src, 0, G_SPDIF, M_SPDIF),
 	KCLK(SPI1_K, "spi1_k", spi123_src, 0, G_SPI1, M_SPI1),
 	KCLK(SPI2_K, "spi2_k", spi123_src, 0, G_SPI2, M_SPI23),
-- 
1.9.1
