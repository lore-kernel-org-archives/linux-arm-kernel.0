From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 16 Oct 2018 16:21:40 +0200
Subject: [PATCH v2 02/22] clk: at91: generated: SSCs don't have a gclk
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
Message-ID: <20181016142200.19741-3-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the SSCs don't have gclk, don't check for their ID to allow them to set
the audio pll rate.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-generated.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 33481368740e..e709a12269c0 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -26,8 +26,6 @@
 #define GENERATED_SOURCE_MAX	6
 #define GENERATED_MAX_DIV	255
 
-#define GCK_ID_SSC0		43
-#define GCK_ID_SSC1		44
 #define GCK_ID_I2S0		54
 #define GCK_ID_I2S1		55
 #define GCK_ID_CLASSD		59
@@ -368,8 +366,7 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 
 		if (of_device_is_compatible(np,
 					    "atmel,sama5d2-clk-generated")) {
-			if (gck->id == GCK_ID_SSC0 || gck->id == GCK_ID_SSC1 ||
-			    gck->id == GCK_ID_I2S0 || gck->id == GCK_ID_I2S1 ||
+			if (gck->id == GCK_ID_I2S0 || gck->id == GCK_ID_I2S1 ||
 			    gck->id == GCK_ID_CLASSD)
 				gck->audio_pll_allowed = true;
 			else
-- 
2.19.1
