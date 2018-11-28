From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:30:02 +0800
Subject: [PATCH 05/15] rtc: sun6i: Add default clock name for LOSC
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
Message-ID: <20181128093013.24442-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC's main clock, used internally and exported to the rest of the
SoC, is called "LOSC" (low speed oscillator) through the hardware
documentation.

This patch adds a default name for this clock, in case the device tree
does not provide one. This shouldn't happen, but lets play it safe.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/rtc-sun6i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index fe07310952df..8edd9e1ec007 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -191,6 +191,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	struct sun6i_rtc_dev *rtc;
 	struct clk_init_data init = {
 		.ops		= &sun6i_rtc_osc_ops,
+		.name		= "losc",
 	};
 	const char *clkout_name = "osc32k-out";
 	const char *parents[2];
-- 
2.20.0.rc1
