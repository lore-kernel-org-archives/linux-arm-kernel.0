From: ddaney.cavm@gmail.com (David Daney)
Date: Mon, 14 Mar 2016 17:30:37 -0700
Subject: [PATCH 1/3] phy: mdio-cavium: Add missing MODULE_* annotations.
In-Reply-To: <1458001839-15993-1-git-send-email-ddaney.cavm@gmail.com>
References: <1458001839-15993-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1458001839-15993-2-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

When the code was factored out of mdio-octeon.c, the
MODULE_DESCRIPTION, MODULE_AUTHOR and MODULE_LICENSE annotations were
inadvertently omitted.  Restore them so that we don't get kernel taint
warnings upon module loading.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/phy/mdio-cavium.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/mdio-cavium.c b/drivers/net/phy/mdio-cavium.c
index e796ee1..6df2fa7 100644
--- a/drivers/net/phy/mdio-cavium.c
+++ b/drivers/net/phy/mdio-cavium.c
@@ -147,3 +147,7 @@ int cavium_mdiobus_write(struct mii_bus *bus, int phy_id, int regnum, u16 val)
 	return 0;
 }
 EXPORT_SYMBOL(cavium_mdiobus_write);
+
+MODULE_DESCRIPTION("Common code for OCTEON and Thunder MDIO bus drivers");
+MODULE_AUTHOR("David Daney");
+MODULE_LICENSE("GPL");
-- 
1.7.11.7
