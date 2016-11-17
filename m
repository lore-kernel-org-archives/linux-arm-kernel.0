From: ping.bai@nxp.com (Bai Ping)
Date: Thu, 17 Nov 2016 09:08:19 +0800
Subject: [PATCH v2 3/3] ARM: dts: imx: Add ocotp node for imx6ul
In-Reply-To: <1479344899-3141-1-git-send-email-ping.bai@nxp.com>
References: <1479344899-3141-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1479344899-3141-3-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ocotp node for i.MX6UL SOC.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index c5c05fd..c6f6613 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -849,6 +849,12 @@
 				reg = <0x021b0000 0x4000>;
 			};
 
+			ocotp: ocotp-ctrl at 021bc000 {
+				compatible = "fsl,imx6ul-ocotp", "syscon";
+				reg = <0x021bc000 0x4000>;
+				clocks = <&clks IMX6UL_CLK_OCOTP>;
+			};
+
 			lcdif: lcdif at 021c8000 {
 				compatible = "fsl,imx6ul-lcdif", "fsl,imx28-lcdif";
 				reg = <0x021c8000 0x4000>;
-- 
1.9.1
