From: otavio@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 20:20:26 -0200
Subject: [PATCH v3 2/3] ARM: imx_v6_v7_defconfig: Enable BT_BNEP
In-Reply-To: <20181125222027.22071-1-otavio@ossystems.com.br>
References: <20181125222027.22071-1-otavio@ossystems.com.br>
Message-ID: <20181125222027.22071-2-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas M?ller <schnitzeltony@gmail.com>

This is necessary to support network over bluetooth:

| Sep 11 15:36:33 imx6qdl-variscite-som bluetoothd[281]: kernel lacks bnep-protocol support
| Sep 11 15:36:33 imx6qdl-variscite-som bluetoothd[281]: System does not support network plugin

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Andreas M?ller <schnitzeltony@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v3: None
Changes in v2: None

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0c887a059df3..22ad2d7a1cf2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -81,6 +81,7 @@ CONFIG_NETFILTER=y
 CONFIG_CAN=y
 CONFIG_CAN_FLEXCAN=y
 CONFIG_BT=y
+CONFIG_BT_BNEP=m
 CONFIG_BT_HCIUART=y
 CONFIG_BT_HCIUART_LL=y
 CONFIG_CFG80211=y
-- 
2.19.2
