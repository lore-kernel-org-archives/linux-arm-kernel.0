From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 29 May 2017 19:09:24 +0200
Subject: [PATCH v1 5/5] ARM: dts: imx6: RIoTboard provide Standby to PowerOff
 option
In-Reply-To: <20170529170924.25488-1-o.rempel@pengutronix.de>
References: <20170529170924.25488-1-o.rempel@pengutronix.de>
Message-ID: <20170529170924.25488-5-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board, as well as some other boards with i.MX6 and a PMIC, uses a
"MPIC_STBY_REQ" line to notify the PMIC about a state change.
The PMIC is programmed for a specific state change before triggering the
line.
In this case, PMIC_STBY_REQ can be used for Stand by, Sleep
and Power off modes.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel at pengutronix.de
Cc: linux-arm-kernel at lists.infradead.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/imx6dl-riotboard.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 2cb72824e800..b5f25fe7b809 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -90,6 +90,10 @@
 	status = "okay";
 };
 
+&clks {
+	fsl,pmic_stby_poweroff;
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
@@ -125,6 +129,7 @@
 		reg = <0x08>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <16 8>;
+		fsl,pmic_stby_poweroff;
 
 		regulators {
 			reg_vddcore: sw1ab {				/* VDDARM_IN */
-- 
2.11.0
