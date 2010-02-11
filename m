From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Thu, 11 Feb 2010 10:05:58 +0100
Subject: [PATCH][KS8695] Mark network interface as running on ifconfig up
Message-ID: <4B73C876.1060906@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[KS8695] Mark network interface as running on ifconfig up

Without netif_carrier_on() network interface will not transmit any packets
after ifconfig down and subsequent ifconfig up.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: linux-2.6.33-rc7/drivers/net/arm/ks8695net.c
===================================================================
--- linux-2.6.33-rc7.orig/drivers/net/arm/ks8695net.c
+++ linux-2.6.33-rc7/drivers/net/arm/ks8695net.c
@@ -1371,6 +1371,7 @@ ks8695_open(struct net_device *ndev)
 
 	napi_enable(&ksp->napi);
 	netif_start_queue(ndev);
+	netif_carrier_on(ndev);
 
 	return 0;
 }
