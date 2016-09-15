From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Sep 2016 23:14:01 +0800
Subject: [PATCH 3/4] drm/sun4i: dotclock: Allow divider = 127
In-Reply-To: <20160915151402.15992-1-wens@csie.org>
References: <20160915151402.15992-1-wens@csie.org>
Message-ID: <20160915151402.15992-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dot clock divider is 7 bits wide, and the divider range is 1 ~ 127,
or 6 ~ 127 if phase offsets are used. The 0 register value also
represents a divider of 1 or bypass.

Make the end condition of the for loop inclusive of 127 in the
round_rate callback.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index 1b6c2253192e..3eb99784f371 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -77,7 +77,7 @@ static long sun4i_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
 	u8 best_div = 1;
 	int i;
 
-	for (i = 6; i < 127; i++) {
+	for (i = 6; i <= 127; i++) {
 		unsigned long ideal = rate * i;
 		unsigned long rounded;
 
-- 
2.9.3
