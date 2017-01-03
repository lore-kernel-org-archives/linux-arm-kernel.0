From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue,  3 Jan 2017 12:22:47 +0100
Subject: [PATCH 2/2] ARM: dts: imx6qdl-nitrogen6_som2: fix sgtl5000 pinctrl
 init
In-Reply-To: <20170103112247.4563-1-gary.bisson@boundarydevices.com>
References: <20170103112247.4563-1-gary.bisson@boundarydevices.com>
Message-ID: <20170103112247.4563-3-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the codec is probed first, the pinctrl node should be
under the codec node.

The codec init was working for this board since U-Boot was
already setting GPIO_0 as CLKO1 but better fix it anyway.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
index d80f21abea62..31d4cc62dbc7 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
@@ -250,8 +250,6 @@
 		compatible = "fsl,imx6q-nitrogen6_som2-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "imx6q-nitrogen6_som2-sgtl5000";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_sgtl5000>;
 		ssi-controller = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
@@ -320,6 +318,8 @@
 
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sgtl5000>;
 		reg = <0x0a>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_2p5v>;
-- 
2.11.0
