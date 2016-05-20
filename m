From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 May 2016 12:07:27 -0700
Subject: [PATCH 2/7] ARM: multi_v7_defconfig: Enable BRCMSTB networking
In-Reply-To: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
References: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1463771252-12805-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the required drivers and subsystems to bring-up networking on
Broadcom's Set-top Box SoCs: BCMGENET and SF2. These two drivers both
have proper dependencies on their internal PHY and MDIO drivers.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 968a7ec08633..31ed7318f406 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -158,6 +158,8 @@ CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_NET_DSA=m
+CONFIG_NET_SWITCHDEV=y
 CONFIG_CAN=y
 CONFIG_CAN_RAW=y
 CONFIG_CAN_BCM=y
@@ -166,6 +168,7 @@ CONFIG_CAN_AT91=m
 CONFIG_CAN_RCAR=m
 CONFIG_CAN_XILINXCAN=y
 CONFIG_CAN_MCP251X=y
+CONFIG_NET_DSA_BCM_SF2=m
 CONFIG_CAN_SUN4I=y
 CONFIG_BT=m
 CONFIG_BT_MRVL=m
@@ -225,6 +228,8 @@ CONFIG_VIRTIO_NET=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_SUN4I_EMAC=y
 CONFIG_MACB=y
+CONFIG_BCMGENET=m
+CONFIG_SYSTEMPORT=m
 CONFIG_NET_CALXEDA_XGMAC=y
 CONFIG_GIANFAR=y
 CONFIG_IGB=y
-- 
2.7.4
