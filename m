From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  2 Dec 2015 00:33:29 +0100
Subject: [PATCH 2/5] ARM: config: Reenable DSA in multi_v5_defconfig
In-Reply-To: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
References: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
Message-ID: <1449012812-9779-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DSA now depends on switchdev. Enable it, and re-enable DSA and its
drivers, which were removed when multi_v5_defconfig was regenerated.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/multi_v5_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index f98d4b8b54c5..920db77916b1 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -37,6 +37,8 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
+CONFIG_NET_DSA=y
+CONFIG_NET_SWITCHDEV=y
 CONFIG_NET_PKTGEN=m
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
@@ -64,6 +66,11 @@ CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
+CONFIG_NET_DSA_MV88E6060=y
+CONFIG_NET_DSA_MV88E6131=y
+CONFIG_NET_DSA_MV88E6123_61_65=y
+CONFIG_NET_DSA_MV88E6171=y
+CONFIG_NET_DSA_MV88E6352=y
 CONFIG_MV643XX_ETH=y
 CONFIG_R8169=y
 CONFIG_MARVELL_PHY=y
-- 
2.6.2
