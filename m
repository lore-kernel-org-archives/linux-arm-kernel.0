From: claudiu.manoil@freescale.com (Claudiu Manoil)
Date: Tue, 28 Jul 2015 17:43:56 +0300
Subject: [PATCH,
 v3 3/3] ARM: dts: ls1021a: Enable the eTSEC ports on QDS and TWR
In-Reply-To: <1438094636-20421-1-git-send-email-claudiu.manoil@freescale.com>
References: <20150727142816.GP12927@tiger>
 <1438094636-20421-1-git-send-email-claudiu.manoil@freescale.com>
Message-ID: <1438094636-20421-3-git-send-email-claudiu.manoil@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the available eTSEC ethernet ports for the
ls1021aqds and ls1021atwr boards.
For the QDS, SGMII connections (via riser cards) are assumed
for the eTSEC0 and eTSEC1 ports as default configuration.

Signed-off-by: Alison Wang <alison.wang@freescale.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
---
v2, v3 - none;

 arch/arm/boot/dts/ls1021a-qds.dts | 20 ++++++++++++++++++++
 arch/arm/boot/dts/ls1021a-twr.dts | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 9c5e16b..f16a061 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -75,6 +75,26 @@
 	};
 };
 
+&enet0 {
+	tbi-handle = <&tbi0>;
+	phy-handle = <&sgmii_phy1c>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&enet1 {
+	tbi-handle = <&tbi0>;
+	phy-handle = <&sgmii_phy1d>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&enet2 {
+	phy-handle = <&rgmii_phy3>;
+	phy-connection-type = "rgmii-id";
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a2c591e..4b61766 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -73,6 +73,26 @@
 	};
 };
 
+&enet0 {
+	tbi-handle = <&tbi1>;
+	phy-handle = <&sgmii_phy2>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&enet1 {
+	tbi-handle = <&tbi1>;
+	phy-handle = <&sgmii_phy0>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&enet2 {
+	phy-handle = <&rgmii_phy1>;
+	phy-connection-type = "rgmii-id";
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 };
-- 
1.7.11.7
