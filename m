From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 18 May 2018 15:15:29 +0530
Subject: [PATCH v2 19/26] arm64: dts: allwinner: a64: Add HDMI pipeline
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Message-ID: <20180518094536.17201-20-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HDMI pipeline on Allwinner A64 has similar behavior like A83T
where tcon1 is connected to HDMI.

Setup the pipeline according to that.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 4ffd4787acd2..8ec6559d10cc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -257,6 +257,10 @@
 					#size-cells = <0>;
 					reg = <1>;
 
+					tcon1_out_hdmi: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&hdmi_in_tcon1>;
+					};
 				};
 			};
 		};
@@ -719,6 +723,23 @@
 			phys = <&hdmi_phy>;
 			phy-names = "hdmi-phy";
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				hdmi_in: port at 0 {
+					reg = <0>;
+
+					hdmi_in_tcon1: endpoint {
+						remote-endpoint = <&tcon1_out_hdmi>;
+					};
+				};
+
+				hdmi_out: port at 1 {
+					reg = <1>;
+				};
+			};
 		};
 
 		hdmi_phy: hdmi-phy at 1ef0000 {
-- 
2.14.3
