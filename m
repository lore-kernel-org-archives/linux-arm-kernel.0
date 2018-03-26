From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 26 Mar 2018 16:18:07 +0800
Subject: [PATCH 1/3] clk: meson: drop CLK_SET_RATE_PARENT flag
In-Reply-To: <20180326081809.49493-1-yixun.lan@amlogic.com>
References: <20180326081809.49493-1-yixun.lan@amlogic.com>
Message-ID: <20180326081809.49493-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk81 is not expected to be changed, so drop this flag.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/gxbb-aoclk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 0f089cbce594..e7bc04d3e24f 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -70,7 +70,7 @@ static struct clk_regmap _name##_ao = {					\
 		.ops = &clk_regmap_gate_ops,				\
 		.parent_names = (const char *[]){ "clk81" },		\
 		.num_parents = 1,					\
-		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
+		.flags = CLK_IGNORE_UNUSED,				\
 	},								\
 }
 
-- 
2.15.1
