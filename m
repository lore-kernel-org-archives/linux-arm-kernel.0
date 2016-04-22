From: harald@ccbib.org (Harald Geyer)
Date: Fri, 22 Apr 2016 13:52:26 +0000
Subject: [PATCH 2/3] ARM: dts: imx23: Provide regulators for the current
 sources of the LRADC
In-Reply-To: <1461333147-11873-1-git-send-email-harald@ccbib.org>
References: <1461333147-11873-1-git-send-email-harald@ccbib.org>
Message-ID: <1461333147-11873-3-git-send-email-harald@ccbib.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the devicetree nodes to make the mxs-lradc driver register
regulator devices for the integrated current sources.

Tested on an imx23-olinuxino board.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
Note: with this configuration the regulator devices will be present but
disabled by default.

 arch/arm/boot/dts/imx23.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 302d116..05ff6f1 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -471,6 +471,14 @@
 				status = "disabled";
 				clocks = <&clks 26>;
 				#io-channel-cells = <1>;
+
+				isrc_lradc0: ISRC0 {
+					regulator-max-microamp = <300>;
+				};
+
+				isrc_lradc1: ISRC1 {
+					regulator-max-microamp = <300>;
+				};
 			};
 
 			spdif at 80054000 {
-- 
2.1.4
