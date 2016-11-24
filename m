From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 24 Nov 2016 14:57:39 +0900
Subject: [PATCH v2 1/3] clk: uniphier: remove unneeded member name for union
Message-ID: <1479967061-25975-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The struct member name of a union is unneeded.  This makes the code
a bit shorter.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Newly added

 drivers/clk/uniphier/clk-uniphier-core.c | 8 ++++----
 drivers/clk/uniphier/clk-uniphier-mio.c  | 2 +-
 drivers/clk/uniphier/clk-uniphier.h      | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index 26c53f7..726a10a 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -29,16 +29,16 @@ static struct clk_hw *uniphier_clk_register(struct device *dev,
 	switch (data->type) {
 	case UNIPHIER_CLK_TYPE_FIXED_FACTOR:
 		return uniphier_clk_register_fixed_factor(dev, data->name,
-							  &data->data.factor);
+							  &data->factor);
 	case UNIPHIER_CLK_TYPE_FIXED_RATE:
 		return uniphier_clk_register_fixed_rate(dev, data->name,
-							&data->data.rate);
+							&data->rate);
 	case UNIPHIER_CLK_TYPE_GATE:
 		return uniphier_clk_register_gate(dev, regmap, data->name,
-						  &data->data.gate);
+						  &data->gate);
 	case UNIPHIER_CLK_TYPE_MUX:
 		return uniphier_clk_register_mux(dev, regmap, data->name,
-						 &data->data.mux);
+						 &data->mux);
 	default:
 		dev_err(dev, "unsupported clock type\n");
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/clk/uniphier/clk-uniphier-mio.c b/drivers/clk/uniphier/clk-uniphier-mio.c
index 218d20f..4974d38 100644
--- a/drivers/clk/uniphier/clk-uniphier-mio.c
+++ b/drivers/clk/uniphier/clk-uniphier-mio.c
@@ -30,7 +30,7 @@
 		.name = "sd" #ch "-sel",				\
 		.type = UNIPHIER_CLK_TYPE_MUX,				\
 		.idx = -1,						\
-		.data.mux = {						\
+		.mux = {						\
 			.parent_names = {				\
 				"sd-44m",				\
 				"sd-33m",				\
diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
index 0244dba..4eb4f6d 100644
--- a/drivers/clk/uniphier/clk-uniphier.h
+++ b/drivers/clk/uniphier/clk-uniphier.h
@@ -62,7 +62,7 @@ struct uniphier_clk_data {
 		struct uniphier_clk_fixed_rate_data rate;
 		struct uniphier_clk_gate_data gate;
 		struct uniphier_clk_mux_data mux;
-	} data;
+	};
 };
 
 #define UNIPHIER_CLK_FACTOR(_name, _idx, _parent, _mult, _div)	\
@@ -70,7 +70,7 @@ struct uniphier_clk_data {
 		.name = (_name),				\
 		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,		\
 		.idx = (_idx),					\
-		.data.factor = {				\
+		.factor = {					\
 			.parent_name = (_parent),		\
 			.mult = (_mult),			\
 			.div = (_div),				\
@@ -83,7 +83,7 @@ struct uniphier_clk_data {
 		.name = (_name),				\
 		.type = UNIPHIER_CLK_TYPE_GATE,			\
 		.idx = (_idx),					\
-		.data.gate = {					\
+		.gate = {					\
 			.parent_name = (_parent),		\
 			.reg = (_reg),				\
 			.bit = (_bit),				\
-- 
2.7.4
