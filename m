From: peng.fan@nxp.com (Peng Fan)
Date: Wed, 1 Mar 2017 14:40:53 +0800
Subject: [PATCH 2/3] arm: dts: imx7s: enable ocotp
In-Reply-To: <1488350454-23860-1-git-send-email-peng.fan@nxp.com>
References: <1488350454-23860-1-git-send-email-peng.fan@nxp.com>
Message-ID: <1488350454-23860-2-git-send-email-peng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ocotp for i.mx7D/S.
Correct the clock entry and compatible string.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 5d3a43b..a7d48e7 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -493,10 +493,9 @@
 			};
 
 			ocotp: ocotp-ctrl at 30350000 {
-				compatible = "syscon";
+				compatible = "fsl,imx7d-ocotp", "syscon";
 				reg = <0x30350000 0x10000>;
-				clocks = <&clks IMX7D_CLK_DUMMY>;
-				status = "disabled";
+				clocks = <&clks IMX7D_OCOTP_CLK>;
 			};
 
 			anatop: anatop at 30360000 {
-- 
2.6.6
