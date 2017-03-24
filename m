From: jagan@openedev.com (Jagan Teki)
Date: Fri, 24 Mar 2017 21:48:46 +0530
Subject: [PATCH v2 11/15] ARM: dts: imx6qdl-icore-rqs: Replace codec 'lable:
 node@addr'
In-Reply-To: <1490372330-5611-1-git-send-email-jagan@openedev.com>
References: <1490372330-5611-1-git-send-email-jagan@openedev.com>
Message-ID: <1490372330-5611-12-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

According to devicetree specification from ePAPER v1.1
[label:] node-name[@unit-address] { };

label: should be human readable string describing a device.
node-name: The name of a node should be somewhat generic,
reflecting the function of the device and not its
unit-address: match the first address specified in the
reg property of the node and shouldn't have leading zeros.

So replaced
codec: sgtl5000 at 0a => sgtl5000: codec at a

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Newly added patch

 arch/arm/boot/dts/imx6dl-icore-rqs.dts   | 2 +-
 arch/arm/boot/dts/imx6q-icore-rqs.dts    | 2 +-
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-icore-rqs.dts b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
index 5b4c14c..053e7cb 100644
--- a/arch/arm/boot/dts/imx6dl-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
@@ -51,7 +51,7 @@
 };
 
 &i2c3 {
-	codec: sgtl5000 at 0a {
+	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
diff --git a/arch/arm/boot/dts/imx6q-icore-rqs.dts b/arch/arm/boot/dts/imx6q-icore-rqs.dts
index 441a28e5..d45e4f5 100644
--- a/arch/arm/boot/dts/imx6q-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6q-icore-rqs.dts
@@ -50,7 +50,7 @@
 };
 
 &i2c3 {
-	codec: sgtl5000 at 0a {
+	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 4032d38..d24e531 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -123,7 +123,7 @@
 		compatible = "fsl,imx-audio-sgtl5000";
 		model = "imx-audio-sgtl5000";
 		ssi-controller = <&ssi1>;
-		audio-codec = <&codec>;
+		audio-codec = <&sgtl5000>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias",
-- 
1.9.1
