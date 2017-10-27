From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Fri, 27 Oct 2017 11:48:48 +0200
Subject: [PATCH v6 6/6] ARM: dts: imx6: RIoTboard provide standby on power off
 option
In-Reply-To: <20171027094848.28365-1-o.rempel@pengutronix.de>
References: <20171027094848.28365-1-o.rempel@pengutronix.de>
Message-ID: <20171027094848.28365-7-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board, as well as some other boards with i.MX6 and a PMIC, uses a
"PMIC_STBY_REQ" line to notify the PMIC about a state change.
The PMIC is programmed for a specific state change before triggering the
line.
In this case, PMIC_STBY_REQ can be used for stand by, sleep
and power off modes.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-riotboard.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 275c6c05219d..574f6b261ecd 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -90,6 +90,10 @@
 	status = "okay";
 };
 
+&clks {
+	fsl,pmic-stby-poweroff;
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
@@ -170,6 +174,7 @@
 		reg = <0x08>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <16 8>;
+		fsl,pmic-stby-poweroff;
 
 		regulators {
 			reg_vddcore: sw1ab {				/* VDDARM_IN */
-- 
2.11.0
