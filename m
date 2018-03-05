From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon,  5 Mar 2018 11:25:23 +0100
Subject: [PATCH v6 6/6] ARM: dts: imx6: RIoTboard provide standby on power off
 option
In-Reply-To: <20180305102524.5905-1-o.rempel@pengutronix.de>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
Message-ID: <20180305102524.5905-7-o.rempel@pengutronix.de>
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
index 23e108204e1e..c507532baed3 100644
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
2.16.1
