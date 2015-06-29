From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 29 Jun 2015 10:05:43 -0300
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Select HCIUART_H4
In-Reply-To: <1435583143-4734-1-git-send-email-fabio.estevam@freescale.com>
References: <1435583143-4734-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1435583143-4734-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old warp board revision had hardware issues that prevented
the RTS/CTS lines to work with the Bluetooth module.

Tha latest rev1.12 fixes this problem, so now we should better use
CONFIG_BT_HCIUART_H4 instead, as it provides a better throughput than
the CONFIG_BT_HCIUART_3WIRE option.

Suggested-by: Arthur Lambert <arthur@dreem.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index b47863d..48133a9 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -76,7 +76,7 @@ CONFIG_CAN_FLEXCAN=y
 CONFIG_BT=y
 CONFIG_BT_HCIUART=y
 CONFIG_BT_HCIUART_LL=y
-CONFIG_BT_HCIUART_3WIRE=y
+CONFIG_BT_HCIUART_H4=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_RFKILL=y
-- 
1.9.1
