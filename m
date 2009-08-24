From: a.beregalov@gmail.com (Alexander Beregalov)
Date: Mon, 24 Aug 2009 18:56:00 +0400
Subject: [PATCH 2/2] irda/sa1100_ir: fix broken netdev_ops conversion
Message-ID: <1251125760-6547-1-git-send-email-a.beregalov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is based on commit d2f3ad4 (pxaficp-ir: remove incorrect
net_device_ops). Do the same for sa1100_ir.
Untested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---
 drivers/net/irda/sa1100_ir.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/net/irda/sa1100_ir.c b/drivers/net/irda/sa1100_ir.c
index 2aeb2e6..b039cb0 100644
--- a/drivers/net/irda/sa1100_ir.c
+++ b/drivers/net/irda/sa1100_ir.c
@@ -24,7 +24,6 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/netdevice.h>
-#include <linux/etherdevice.h>
 #include <linux/slab.h>
 #include <linux/rtnetlink.h>
 #include <linux/interrupt.h>
@@ -881,9 +880,6 @@ static const struct net_device_ops sa1100_irda_netdev_ops = {
 	.ndo_stop		= sa1100_irda_stop,
 	.ndo_start_xmit		= sa1100_irda_hard_xmit,
 	.ndo_do_ioctl		= sa1100_irda_ioctl,
-	.ndo_change_mtu		= eth_change_mtu,
-	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_mac_address	= eth_mac_addr,
 };
 
 static int sa1100_irda_probe(struct platform_device *pdev)
-- 
1.6.4
