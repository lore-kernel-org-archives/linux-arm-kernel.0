From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Mar 2013 13:08:58 +0100
Subject: [PATCH 3/7] ARM: i.MX31: Add GPT devicetree node
In-Reply-To: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
References: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1363262942-26702-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPT is the GPT timer found on i.MX SoCs.

Since this is the first user of the AIPS2 this patch also adds it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx31.dtsip | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx31.dtsip b/arch/arm/boot/dts/imx31.dtsip
index aa488ac..c544925 100644
--- a/arch/arm/boot/dts/imx31.dtsip
+++ b/arch/arm/boot/dts/imx31.dtsip
@@ -101,5 +101,21 @@
 				#clock-cells = <1>;
 			};
 		};
+
+		aips at 53f00000 { /* AIPS2 */
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x53f00000 0x100000>;
+			ranges;
+
+			gpt: timer at 53f90000 {
+				compatible = "fsl,imx31-gpt";
+				reg = <0x53f90000 0x4000>;
+				interrupts = <29>;
+				clocks = <&clks 10>, <&clks 22>;
+				clock-names = "ipg", "per";
+			};
+		};
 	};
 };
-- 
1.8.2.rc2
