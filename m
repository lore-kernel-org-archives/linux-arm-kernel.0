From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 15 Jun 2016 23:41:14 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Ethernet Switch drivers
Message-ID: <1466026874-11971-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernelci now has two boards with Ethernet switches supported by DSA.
Enable DSA and the switch drivers so we get some boot testing.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8f857564657f..b45ac256b491 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -157,6 +157,8 @@ CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_NET_DSA=y
+CONFIG_NET_SWITCHDEV=y
 CONFIG_CAN=y
 CONFIG_CAN_RAW=y
 CONFIG_CAN_BCM=y
@@ -222,6 +224,8 @@ CONFIG_SATA_RCAR=y
 CONFIG_NETDEVICES=y
 CONFIG_VIRTIO_NET=y
 CONFIG_HIX5HD2_GMAC=y
+CONFIG_NET_DSA_MV88E6XXX=y
+CONFIG_NET_DSA_BCM_SF2=y
 CONFIG_SUN4I_EMAC=y
 CONFIG_MACB=y
 CONFIG_NET_CALXEDA_XGMAC=y
-- 
2.8.1
