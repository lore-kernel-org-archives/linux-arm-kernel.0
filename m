From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Mar 2013 13:09:00 +0100
Subject: [PATCH 5/7] ARM: i.MX53: Add GPT devicetree node
In-Reply-To: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
References: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1363262942-26702-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPT is the GPT timer found on i.MX SoCs. This patch adds the
devicetree node for it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsip | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsip b/arch/arm/boot/dts/imx53.dtsip
index 98149ac..6c73bee 100644
--- a/arch/arm/boot/dts/imx53.dtsip
+++ b/arch/arm/boot/dts/imx53.dtsip
@@ -243,6 +243,14 @@
 				status = "disabled";
 			};
 
+			gpt: timer at 53fa0000 {
+				compatible = "fsl,imx53-gpt", "fsl,imx31-gpt";
+				reg = <0x53fa0000 0x4000>;
+				interrupts = <39>;
+				clocks = <&clks 36>, <&clks 41>;
+				clock-names = "ipg", "per";
+			};
+
 			iomuxc: iomuxc at 53fa8000 {
 				compatible = "fsl,imx53-iomuxc";
 				reg = <0x53fa8000 0x4000>;
-- 
1.8.2.rc2
