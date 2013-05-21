From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 May 2013 18:41:41 +0200
Subject: [PATCH v4 03/12] net: mv643xx_eth: add phy_node to platform_data
 struct
In-Reply-To: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1369154510-4927-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a struct device_node pointer for a phy passed by phandle
to mv643xx_eth node.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: David Miller <davem@davemloft.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: netdev at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-kernel at vger.kernel.org
---
 include/linux/mv643xx_eth.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mv643xx_eth.h b/include/linux/mv643xx_eth.h
index 141d395..6e8215b 100644
--- a/include/linux/mv643xx_eth.h
+++ b/include/linux/mv643xx_eth.h
@@ -30,6 +30,7 @@ struct mv643xx_eth_shared_platform_data {
 #define MV643XX_ETH_PHY_ADDR(x)		(0x80 | (x))
 #define MV643XX_ETH_PHY_NONE		0xff
 
+struct device_node;
 struct mv643xx_eth_platform_data {
 	/*
 	 * Pointer back to our parent instance, and our port number.
@@ -41,6 +42,7 @@ struct mv643xx_eth_platform_data {
 	 * Whether a PHY is present, and if yes, at which address.
 	 */
 	int			phy_addr;
+	struct device_node	*phy_node;
 
 	/*
 	 * Use this MAC address if it is valid, overriding the
-- 
1.7.10.4
