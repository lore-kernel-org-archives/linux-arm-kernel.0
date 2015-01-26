From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 26 Jan 2015 11:49:56 -0800
Subject: [PATCH 2/2] ARM: zynq: DT: Add pinctrl information to USB nodes
In-Reply-To: <1422301796-22888-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1422301796-22888-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1422301796-22888-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
Hi Michal,

This could be squashed into 1643b31658c4 'ARM: zynq: DT: Add USB to
device tree' if you decide to rebuild the zynq/dt branch.

	S?ren
---
 arch/arm/boot/dts/zynq-zc702.dts | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zc706.dts | 26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 4f8835be4874..483f69ba2cf5 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -312,6 +312,30 @@
 			bias-disable;
 		};
 	};
+
+	pinctrl_usb0_default: usb0-default {
+		mux {
+			groups = "usb0_0_grp";
+			function = "usb0";
+		};
+
+		conf {
+			groups = "usb0_0_grp";
+			slew-rate = <0>;
+			io-standard = <1>;
+		};
+
+		conf-rx {
+			pins = "MIO29", "MIO31", "MIO36";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO28", "MIO30", "MIO32", "MIO33", "MIO34",
+			       "MIO35", "MIO37", "MIO38", "MIO39";
+			bias-disable;
+		};
+	};
 };
 
 &sdhci0 {
@@ -330,4 +354,6 @@
 	status = "okay";
 	dr_mode = "host";
 	usb-phy = <&usb_phy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_default>;
 };
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 6979ce23175f..3a6260998116 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -261,6 +261,30 @@
 			bias-disable;
 		};
 	};
+
+	pinctrl_usb0_default: usb0-default {
+		mux {
+			groups = "usb0_0_grp";
+			function = "usb0";
+		};
+
+		conf {
+			groups = "usb0_0_grp";
+			slew-rate = <0>;
+			io-standard = <1>;
+		};
+
+		conf-rx {
+			pins = "MIO29", "MIO31", "MIO36";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO28", "MIO30", "MIO32", "MIO33", "MIO34",
+			       "MIO35", "MIO37", "MIO38", "MIO39";
+			bias-disable;
+		};
+	};
 };
 
 &sdhci0 {
@@ -279,4 +303,6 @@
 	status = "okay";
 	dr_mode = "host";
 	usb-phy = <&usb_phy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_default>;
 };
-- 
2.2.2.1.g63c5777
