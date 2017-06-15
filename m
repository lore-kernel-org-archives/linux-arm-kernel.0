From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 15 Jun 2017 16:43:18 +0200
Subject: [PATCH net-next v5 03/11] net: mvmdio: use GENMASK for masks
In-Reply-To: <20170615144326.24463-1-antoine.tenart@free-electrons.com>
References: <20170615144326.24463-1-antoine.tenart@free-electrons.com>
Message-ID: <20170615144326.24463-4-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cosmetic patch to use the GENMASK helper for masks.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 17b518b13ae3..583f1c5753c2 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -138,7 +138,7 @@ static int orion_mdio_read(struct mii_bus *bus, int mii_id,
 		goto out;
 	}
 
-	ret = val & 0xFFFF;
+	ret = val & GENMASK(15, 0);
 out:
 	mutex_unlock(&dev->lock);
 	return ret;
-- 
2.9.4
