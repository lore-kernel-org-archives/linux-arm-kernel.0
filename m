From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 20 Sep 2016 14:01:43 +0900
Subject: [PATCH] ARM: cache-uniphier: rename jump label to follow coding style
 guideline
Message-ID: <1474347703-17799-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation/CodingStyle recommends to use label names which say
what the goto does or why the goto exists.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mm/cache-uniphier.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
index eac516a..9a2a249 100644
--- a/arch/arm/mm/cache-uniphier.c
+++ b/arch/arm/mm/cache-uniphier.c
@@ -375,7 +375,7 @@ static int __init __uniphier_cache_init(struct device_node *np,
 		pr_err("L%d: cache-line-size is unspecified or invalid\n",
 		       *cache_level);
 		ret = -EINVAL;
-		goto err;
+		goto iounmap;
 	}
 
 	if (of_property_read_u32(np, "cache-sets", &data->nsets) ||
@@ -383,7 +383,7 @@ static int __init __uniphier_cache_init(struct device_node *np,
 		pr_err("L%d: cache-sets is unspecified or invalid\n",
 		       *cache_level);
 		ret = -EINVAL;
-		goto err;
+		goto iounmap;
 	}
 
 	if (of_property_read_u32(np, "cache-size", &cache_size) ||
@@ -391,7 +391,7 @@ static int __init __uniphier_cache_init(struct device_node *np,
 		pr_err("L%d: cache-size is unspecified or invalid\n",
 		       *cache_level);
 		ret = -EINVAL;
-		goto err;
+		goto iounmap;
 	}
 
 	data->way_present_mask =
@@ -401,21 +401,21 @@ static int __init __uniphier_cache_init(struct device_node *np,
 	if (!data->ctrl_base) {
 		pr_err("L%d: failed to map control register\n", *cache_level);
 		ret = -ENOMEM;
-		goto err;
+		goto iounmap;
 	}
 
 	data->rev_base = of_iomap(np, 1);
 	if (!data->rev_base) {
 		pr_err("L%d: failed to map revision register\n", *cache_level);
 		ret = -ENOMEM;
-		goto err;
+		goto iounmap;
 	}
 
 	data->op_base = of_iomap(np, 2);
 	if (!data->op_base) {
 		pr_err("L%d: failed to map operation register\n", *cache_level);
 		ret = -ENOMEM;
-		goto err;
+		goto iounmap;
 	}
 
 	data->way_ctrl_base = data->ctrl_base + 0xc00;
@@ -465,7 +465,7 @@ static int __init __uniphier_cache_init(struct device_node *np,
 	of_node_put(next_np);
 
 	return ret;
-err:
+iounmap:
 	iounmap(data->op_base);
 	iounmap(data->rev_base);
 	iounmap(data->ctrl_base);
-- 
1.9.1
