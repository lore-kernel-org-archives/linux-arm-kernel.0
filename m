From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 20 Dec 2013 19:42:53 -0800
Subject: [PATCH 2/5] arm64: dts: APM X-Gene SoC Ethernet device tree nodes
In-Reply-To: <1387597376-29303-1-git-send-email-isubramanian@apm.com>
References: <1387597376-29303-1-git-send-email-isubramanian@apm.com>
Message-ID: <1387597376-29303-3-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree files for APM X-Gene SoC Ethernet.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Ravi Patel <rapatel@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
---
 arch/arm64/boot/dts/apm-mustang.dts |    8 ++++++++
 arch/arm64/boot/dts/apm-storm.dtsi  |   19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-mustang.dts b/arch/arm64/boot/dts/apm-mustang.dts
index 1247ca1..ccb2771 100644
--- a/arch/arm64/boot/dts/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm-mustang.dts
@@ -17,6 +17,10 @@
 	model = "APM X-Gene Mustang board";
 	compatible = "apm,mustang", "apm,xgene-storm";
 
+        aliases {
+                ethernet0 = &menet;
+        };
+
 	chosen { };
 
 	memory {
@@ -24,3 +28,7 @@
 		reg = < 0x1 0x00000000 0x0 0x80000000 >; /* Updated by bootloader */
 	};
 };
+
+&menet {
+        status = "ok";
+};
diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index f64f946..9c7b8cd 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -204,5 +204,24 @@
 			#clock-cells = <1>;
 			clocks = <&qmlclk 0>;
 		};
+
+		menet: ethernet at 17020000 {
+			compatible = "apm,xgene-enet";
+			status = "disabled";
+			reg = <0x0 0x17020000 0x0 0x30>,
+			      <0x0 0x17020000 0x0 0x10000>,
+			      <0x0 0x17020000 0x0 0x20>;
+			slave-name = "RGMII";
+			interrupts = <0x0 0x38 0x4>,
+				     <0x0 0x39 0x4>,
+				     <0x0 0x3a 0x4>;
+			#clock-cells = <1>;
+			clocks = <&eth8clk 0>;
+			local-mac-address = <0x0 0x11 0x3a 0x8a 0x5a 0x78>;
+			max-frame-size = <0x233a>;
+			devid = <8>;
+			phyid = <3>;
+			phy-mode = "rgmii";
+		};
 	};
 };
-- 
1.7.9.5
