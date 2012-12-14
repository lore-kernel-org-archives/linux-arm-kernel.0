From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 14 Dec 2012 11:03:04 +0530
Subject: [PATCH v2 8/8] ARM: OMAP2+: omap2plus_defconfig: Enable DCAN
 controller
In-Reply-To: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
References: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
Message-ID: <1355463184-16283-9-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM335X-EVM has BOSCH DCAN controller, one has to manually enable
this support to use of DCAN controller. So this patch enables DCAN
driver in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b0ad0b0..0ce6771 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -52,6 +52,11 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
+CONFIG_CAN=y
+CONFIG_CAN_RAW=y
+CONFIG_CAN_BCM=y
+CONFIG_CAN_C_CAN=y
+CONFIG_CAN_C_CAN_PLATFORM=y
 CONFIG_BT=m
 CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_H4=y
-- 
1.7.9.5
