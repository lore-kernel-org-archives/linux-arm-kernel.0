From: yankejian@huawei.com (yankejian)
Date: Mon, 7 Dec 2015 16:25:07 +0800
Subject: [PATCH v2 next 2/2] net: hns: fixes no syscon error when init mdio
In-Reply-To: <1449476707-224320-1-git-send-email-yankejian@huawei.com>
References: <1449476707-224320-1-git-send-email-yankejian@huawei.com>
Message-ID: <1449476707-224320-3-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as dtsi files use the normal naming conventions using '-' instead of '_'
inside of property names, the driver needs to update the phandle name
strings of the of_parse_phandle func.

Signed-off-by: yankejian <yankejian@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 37491c8..1e07e91 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -458,7 +458,7 @@ static int hns_mdio_probe(struct platform_device *pdev)
 	}
 
 	mdio_dev->subctrl_vbase =
-		syscon_node_to_regmap(of_parse_phandle(np, "subctrl_vbase", 0));
+		syscon_node_to_regmap(of_parse_phandle(np, "subctrl-vbase", 0));
 	if (IS_ERR(mdio_dev->subctrl_vbase)) {
 		dev_warn(&pdev->dev, "no syscon hisilicon,peri-c-subctrl\n");
 		mdio_dev->subctrl_vbase = NULL;
-- 
1.9.1
