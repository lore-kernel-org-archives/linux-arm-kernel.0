From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 19 Apr 2018 21:54:25 +0800
Subject: [PATCH v6 6/7] clk: meson: drop CLK_SET_RATE_PARENT flag
In-Reply-To: <20180419135426.155794-1-yixun.lan@amlogic.com>
References: <20180419135426.155794-1-yixun.lan@amlogic.com>
Message-ID: <20180419135426.155794-7-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk81 is not expected to be changed, so drop this flag.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/gxbb-aoclk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index c785ee7586d1..e145ebcdef38 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -69,7 +69,7 @@ static struct clk_regmap _name##_ao = {					\
 		.ops = &clk_regmap_gate_ops,				\
 		.parent_names = (const char *[]){ "clk81" },		\
 		.num_parents = 1,					\
-		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
+		.flags = CLK_IGNORE_UNUSED,				\
 	},								\
 }
 
-- 
2.15.1
