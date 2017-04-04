From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 4 Apr 2017 20:04:13 +0300
Subject: [PATCH v2 3/4] ARM: dts: imx6qdl-sabresd: Set LDO regulator supply
In-Reply-To: <cover.1491324640.git.leonard.crestez@nxp.com>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
Message-ID: <0e90881cb5b766eec66db692522591aa47165663.1491324640.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting the supply is optional but beneficial, it will cause PMIC
voltages to be dynamically changed with cpu frequency.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 63bf95e..58055ce 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -548,6 +548,18 @@
 	status = "okay";
 };
 
+&reg_arm {
+       vin-supply = <&sw1a_reg>;
+};
+
+&reg_pu {
+       vin-supply = <&sw1c_reg>;
+};
+
+&reg_soc {
+       vin-supply = <&sw1c_reg>;
+};
+
 &snvs_poweroff {
 	status = "okay";
 };
-- 
2.7.4
