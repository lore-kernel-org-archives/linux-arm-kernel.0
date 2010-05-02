From: mattias@vmlinux.org (Mattias Walstrom)
Date: Sun, 02 May 2010 22:32:24 +0200
Subject: [PATCH] fec.c: Fix memory corruption in fec_set_mac_address.
Message-ID: <4BDDE158.1050404@vmlinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix memory corruption that may result in kernel panics.

Signed-off-by: Mattias Walstr?m <mattias@vmlinux.org>

fec.c |    2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 9f98c1c..9b4e8f7 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -1653,7 +1653,7 @@ fec_set_mac_address(struct net_device *dev, void *p)
 		(dev->dev_addr[1] << 16) | (dev->dev_addr[0] << 24),
 		fep->hwp + FEC_ADDR_LOW);
 	writel((dev->dev_addr[5] << 16) | (dev->dev_addr[4] << 24),
-		fep + FEC_ADDR_HIGH);
+		fep->hwp + FEC_ADDR_HIGH);
 	return 0;
 }
 
