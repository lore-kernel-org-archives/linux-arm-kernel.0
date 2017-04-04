From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 4 Apr 2017 20:04:14 +0300
Subject: [PATCH v2 4/4] ARM: dts: imx6qp-sabresd: Set reg_arm regulator supply
In-Reply-To: <cover.1491324640.git.leonard.crestez@nxp.com>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
Message-ID: <f032759a6df750e504d040dfc80d834046c4c540.1491324640.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On imx6qp-sabresd LDO_ARM is connected to a different PMIC output than
the other imx6qdl-sabresd boards.

Setting cpu0 arm-supply to sw2_reg is wrong, this must have mistakenly
slipped out of the vendor tree where this is are used for LDO bypass.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qp-sabresd.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/imx6qp-sabresd.dts
index b234580..a8a5004 100644
--- a/arch/arm/boot/dts/imx6qp-sabresd.dts
+++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
@@ -50,8 +50,8 @@
 	compatible = "fsl,imx6qp-sabresd", "fsl,imx6qp";
 };
 
-&cpu0 {
-	arm-supply = <&sw2_reg>;
+&reg_arm {
+	vin-supply = <&sw2_reg>;
 };
 
 &iomuxc {
-- 
2.7.4
