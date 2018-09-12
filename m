From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 12 Sep 2018 17:35:49 +0200
Subject: [PATCH] clk: mvebu: ap806: Remove superfluous of_clk_add_provider
Message-ID: <20180912153549.14437-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While applying the commit a8309cedcdce ("clk: apn806: Add eMMC clock to
system controller driver"), of_clk_add_provider was added wheres it was
already present in the probe function.

This extraneous call is harmless but not useful so remove it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/clk/mvebu/ap806-system-controller.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
index 9fbec3eb725f..ea54a874bbda 100644
--- a/drivers/clk/mvebu/ap806-system-controller.c
+++ b/drivers/clk/mvebu/ap806-system-controller.c
@@ -153,7 +153,6 @@ static int ap806_syscon_common_probe(struct platform_device *pdev,
 		goto fail4;
 	}
 
-	of_clk_add_provider(np, of_clk_src_onecell_get, &ap806_clk_data);
 	ret = of_clk_add_provider(np, of_clk_src_onecell_get, &ap806_clk_data);
 	if (ret)
 		goto fail_clk_add;
-- 
2.18.0
