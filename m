From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 27 Jul 2017 15:09:39 +0200
Subject: [PATCH 1/2] clk: meson: gxbb: fix meson cts_amclk divider flags
In-Reply-To: <20170727130940.18005-1-jbrunet@baylibre.com>
References: <20170727130940.18005-1-jbrunet@baylibre.com>
Message-ID: <20170727130940.18005-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_DIVIDER_ROUND_CLOSEST was incorrectly put in the hw.init flags
while it should have been in the divider flags

Fixes: 4087bd4b2170 ("clk: meson: gxbb: add cts_amclk")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index a897ea45327c..b1b72524153b 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -845,13 +845,14 @@ static struct meson_clk_audio_divider gxbb_cts_amclk_div = {
 		.shift   = 0,
 		.width   = 8,
 	},
+	.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	.lock = &clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_amclk_div",
 		.ops = &meson_clk_audio_divider_ops,
 		.parent_names = (const char *[]){ "cts_amclk_sel" },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_DIVIDER_ROUND_CLOSEST,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.9.4
