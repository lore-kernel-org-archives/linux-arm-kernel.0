From: robh@kernel.org (Rob Herring)
Date: Fri, 16 Nov 2018 16:05:40 -0600
Subject: [PATCH] pinctrl: mediatek: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20181116220540.17222-1-robh@kernel.org>
References: <20181116220540.17222-1-robh@kernel.org>
Message-ID: <20181116220540.17222-4-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Sean Wang <sean.wang@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek at lists.infradead.org
Cc: linux-gpio at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index d2179028f134..7ff5ffa88198 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -419,8 +419,8 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 
 	pins = of_find_property(node, "pinmux", NULL);
 	if (!pins) {
-		dev_err(hw->dev, "missing pins property in node %s .\n",
-			node->name);
+		dev_err(hw->dev, "missing pins property in node %pOFn .\n",
+			node);
 		return -EINVAL;
 	}
 
-- 
2.19.1
