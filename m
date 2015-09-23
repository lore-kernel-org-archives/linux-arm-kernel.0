From: davem@davemloft.net (David Miller)
Date: Wed, 23 Sep 2015 16:24:17 -0700 (PDT)
Subject: [PATCH v2 0/9] Phy, mdiobus, and netdev struct device fixes
In-Reply-To: <20150922161710.GA21084@n2100.arm.linux.org.uk>
References: <20150922161710.GA21084@n2100.arm.linux.org.uk>
Message-ID: <20150923.162417.814596822188458346.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 22 Sep 2015 17:17:10 +0100

> This is the second version of the series, with the comments David had
> on the first patch fixed up.  Original series description with updated
> diffstat below.

This needs some build fixes:

drivers/net/ethernet/apm/xgene/xgene_enet_hw.c: In function ?xgene_enet_phy_connect?:
drivers/net/ethernet/apm/xgene/xgene_enet_hw.c:694:20: error: too few arguments to function ?of_phy_connect?
   pdata->phy_dev = of_phy_connect(ndev, phy_np,
                    ^
In file included from drivers/net/ethernet/apm/xgene/xgene_enet_main.h:31:0,
                 from drivers/net/ethernet/apm/xgene/xgene_enet_hw.c:22:
include/linux/of_mdio.h:18:27: note: declared here
 extern struct phy_device *of_phy_connect(struct net_device *dev,
                           ^
