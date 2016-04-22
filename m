From: harald@ccbib.org (Harald Geyer)
Date: Fri, 22 Apr 2016 13:52:27 +0000
Subject: [PATCH 3/3] ARM: dts: imx28: Provide regulators for the current
 sources of the LRADC
In-Reply-To: <1461333147-11873-1-git-send-email-harald@ccbib.org>
References: <1461333147-11873-1-git-send-email-harald@ccbib.org>
Message-ID: <1461333147-11873-4-git-send-email-harald@ccbib.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the devicetree nodes to make the mxs-lradc driver register
regulator devices for the integrated current sources.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
I couln't test this patch on actual HW, but it is a straight forward
port from the imx23 case. With only a funny change in the node label,
to match the naming convention of the IMX28 Reference Manual.

 arch/arm/boot/dts/imx28.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index f637ec9..38f8675 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1070,6 +1070,14 @@
 				status = "disabled";
 				clocks = <&clks 41>;
 				#io-channel-cells = <1>;
+
+				isrc_lradc0: ISRC0 {
+					regulator-max-microamp = <300>;
+				};
+
+				isrc_lradc6: ISRC1 {
+					regulator-max-microamp = <300>;
+				};
 			};
 
 			spdif: spdif at 80054000 {
-- 
2.1.4
