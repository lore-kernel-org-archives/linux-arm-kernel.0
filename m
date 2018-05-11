From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 11 May 2018 19:40:37 +0530
Subject: [PATCH 2/2] clk: davinci: psc-dm365: fix few clocks
In-Reply-To: <20180511141037.25250-1-nsekhar@ti.com>
References: <20180511141037.25250-1-nsekhar@ti.com>
Message-ID: <20180511141037.25250-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix parent of emac and voice codec PSC clocks. This now matches
existing implementation in arch/arm/mach-davinci/dm365.c

Also, there is only one power domain on DM365. Fix the power
domain of voice codec and vpss dac modules.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/clk/davinci/psc-dm365.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/davinci/psc-dm365.c b/drivers/clk/davinci/psc-dm365.c
index 5b5b55b0b59a..beeda10fd2f0 100644
--- a/drivers/clk/davinci/psc-dm365.c
+++ b/drivers/clk/davinci/psc-dm365.c
@@ -65,9 +65,9 @@ static const struct davinci_lpsc_clk_info dm365_psc_info[] = {
 	LPSC(31, 0, arm,         pll2_sysclk2, NULL,               LPSC_ALWAYS_ENABLED),
 	LPSC(38, 0, spi3,        pll1_sysclk4, spi3_clkdev,        0),
 	LPSC(39, 0, spi4,        pll1_auxclk,  spi4_clkdev,        0),
-	LPSC(40, 0, emac,        pll2_sysclk4, emac_clkdev,        0),
-	LPSC(44, 1, voice_codec, pll1_sysclk3, voice_codec_clkdev, 0),
-	LPSC(46, 1, vpss_dac,    pll1_sysclk3, vpss_dac_clkdev,    0),
+	LPSC(40, 0, emac,        pll1_sysclk4, emac_clkdev,        0),
+	LPSC(44, 0, voice_codec, pll2_sysclk4, voice_codec_clkdev, 0),
+	LPSC(46, 0, vpss_dac,    pll1_sysclk3, vpss_dac_clkdev,    0),
 	LPSC(47, 0, vpss_master, pll1_sysclk5, vpss_master_clkdev, 0),
 	LPSC(50, 0, mjcp,        pll1_sysclk3, NULL,               0),
 	{ }
-- 
2.16.2
