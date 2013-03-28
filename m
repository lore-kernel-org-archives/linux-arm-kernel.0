From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 28 Mar 2013 16:23:33 +0100
Subject: [PATCH v3 09/11] ARM i.MX53: Add IOMUXC GPR to device tree
In-Reply-To: <1364484215-13935-1-git-send-email-p.zabel@pengutronix.de>
References: <1364484215-13935-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1364484215-13935-10-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 7a6f5a8..b07bbdcc 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -506,6 +506,11 @@
 
 			};
 
+			gpr: iomuxc-gpr at 53fa8000 {
+				compatible = "fsl,imx53-iomuxc-gpr", "syscon";
+				reg = <0x53fa8000 0xc>;
+			};
+
 			pwm1: pwm at 53fb4000 {
 				#pwm-cells = <2>;
 				compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
-- 
1.8.2.rc2
