From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Mar 2013 13:08:59 +0100
Subject: [PATCH 4/7] ARM: i.MX51: Add GPT devicetree node
In-Reply-To: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
References: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1363262942-26702-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPT is the GPT timer found on i.MX SoCs. This patch adds the
devicetree node for it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsip | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsip b/arch/arm/boot/dts/imx51.dtsip
index 6e14b75..fd3ddef 100644
--- a/arch/arm/boot/dts/imx51.dtsip
+++ b/arch/arm/boot/dts/imx51.dtsip
@@ -245,6 +245,14 @@
 				status = "disabled";
 			};
 
+			gpt: timer at 73fa0000 {
+				compatible = "fsl,imx51-gpt", "fsl,imx31-gpt";
+				reg = <0x73fa0000 0x4000>;
+				interrupts = <39>;
+				clocks = <&clks 36>, <&clks 41>;
+				clock-names = "ipg", "per";
+			};
+
 			iomuxc: iomuxc at 73fa8000 {
 				compatible = "fsl,imx51-iomuxc";
 				reg = <0x73fa8000 0x4000>;
-- 
1.8.2.rc2
