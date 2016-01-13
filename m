From: yankejian@huawei.com (Kejian Yan)
Date: Wed, 13 Jan 2016 11:01:13 +0800
Subject: [patch v3 net-next 2/2] net: hns: fixes no syscon error when init mdio
In-Reply-To: <1452654073-28039-1-git-send-email-yankejian@huawei.com>
References: <1452654073-28039-1-git-send-email-yankejian@huawei.com>
Message-ID: <1452654073-28039-4-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As dtsi files use the normal naming conventions using '-' instead of '_'
inside of property names, the driver needs to update the phandle name
strings of the of_parse_phandle func.

Signed-off-by: Kejian Yan <yankejian@huawei.com>
---
change log:
v3:
 same as v2

v2:
 adds the initial version, because using '-' instead of '_'

v1:
 does not exist.

v2 patch link: https://lkml.org/lkml/2015/12/7/77
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
2.4.1
