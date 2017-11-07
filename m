From: ran.wang_1@nxp.com (Ran Wang)
Date: Tue, 7 Nov 2017 15:20:54 +0800
Subject: [PATCH v2 2/3] arm64: dts: ls1043a: Enable USB 3.0 phy driver
In-Reply-To: <20171107072055.26945-1-ran.wang_1@nxp.com>
References: <20171107072055.26945-1-ran.wang_1@nxp.com>
Message-ID: <20171107072055.26945-2-ran.wang_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds entries in dts to enable USB 3.0 PHY driver.

Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v2:
	- Rename node name from 'usb3-phy' to 'usb-phy'
	- Adjust phy node position 

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 31fd77f82ced..83d4e9e574ba 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -620,6 +620,8 @@
 			reg = <0x0 0x2f00000 0x0 0x10000>;
 			interrupts = <0 60 0x4>;
 			dr_mode = "host";
+			phys = <&usbphy0>;
+			phy-names = "usb-phy";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 		};
@@ -629,6 +631,8 @@
 			reg = <0x0 0x3000000 0x0 0x10000>;
 			interrupts = <0 61 0x4>;
 			dr_mode = "host";
+			phys = <&usbphy1>;
+			phy-names = "usb-phy";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 		};
@@ -638,6 +642,8 @@
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <0 63 0x4>;
 			dr_mode = "host";
+			phys = <&usbphy2>;
+			phy-names = "usb-phy";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 		};
@@ -747,6 +753,33 @@
 					<0000 0 0 3 &gic 0 156 0x4>,
 					<0000 0 0 4 &gic 0 157 0x4>;
 		};
+
+		usbphy0: usb-phy at 084f0000 {
+			compatible = "fsl,qoriq-usb3-phy";
+			reg = <0x0 0x01570070 0x0 0xC>,
+			      <0x0 0x084F0000 0x0 0x5000>;
+			reg-names = "param_ctrl", "phy_base";
+			#phy-cells = <0>;
+			phy_type = "utmi";
+		};
+
+		usbphy1: usb-phy at 08500000 {
+			compatible = "fsl,qoriq-usb3-phy";
+			reg = <0x0 0x0157007C 0x0 0xC>,
+			      <0x0 0x08500000 0x0 0x5000>;
+			reg-names = "param_ctrl", "phy_base";
+			#phy-cells = <0>;
+			phy_type = "utmi";
+		};
+
+		usbphy2: usb-phy at 08510000 {
+			compatible = "fsl,qoriq-usb3-phy";
+			reg = <0x0 0x01570088 0x0 0xC>,
+			      <0x0 0x08510000 0x0 0x5000>;
+			reg-names = "param_ctrl", "phy_base";
+			#phy-cells = <0>;
+			phy_type = "utmi";
+		};
 	};
 
 };
-- 
2.14.1
