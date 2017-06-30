From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Jun 2017 17:43:03 -0300
Subject: [PATCH 2/4] ARM: dts: imx7d-sdb: Pass phy-reset-gpios
In-Reply-To: <1498855385-9690-1-git-send-email-festevam@gmail.com>
References: <1498855385-9690-1-git-send-email-festevam@gmail.com>
Message-ID: <1498855385-9690-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass the phy-reset-gpios property so that Ethernet PHYs can go
through a proper reset.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 0a24d1b..664582d 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -168,6 +168,7 @@
 	phy-mode = "rgmii";
 	phy-handle = <&ethphy0>;
 	fsl,magic-packet;
+	phy-reset-gpios = <&extended_io 5 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	mdio {
-- 
2.7.4
