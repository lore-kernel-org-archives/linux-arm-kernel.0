From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Thu, 14 Dec 2017 11:30:11 +0100
Subject: [PATCH v3 11/11] ARM64: dts: marvell: Add thermal support for A7K/A8K
In-Reply-To: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
Message-ID: <20171214103011.24713-12-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add thermal DT nodes in AP806 and CP110 master/slave DTSI files.

Suggested-by: David Sniatkiwicz <davidsn@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi        | 7 +++++++
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 7 +++++++
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 1c4dd8ab9ad5..ceda98a4f8cc 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -285,6 +285,13 @@
 					gpio-ranges = <&ap_pinctrl 0 0 20>;
 				};
 			};
+
+			ap_thermal: thermal at 6f808C {
+				compatible = "marvell,armada-ap806-thermal";
+				reg = <0x6f808C 0x4>,
+				      <0x6f8084 0x8>;
+				marvell,thermal-zone-name = "ap_thermal_zone";
+			};
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index e3b64d03fbd8..0dc92897fd7c 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -182,6 +182,13 @@
 				interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
+			cpm_thermal: thermal at 400078 {
+				compatible = "marvell,armada-cp110-thermal";
+				reg = <0x400078 0x4>,
+				      <0x400070 0x8>;
+				marvell,thermal-zone-name = "cp0_thermal_zone";
+			};
+
 			cpm_syscon0: system-controller at 440000 {
 				compatible = "syscon", "simple-mfd";
 				reg = <0x440000 0x2000>;
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 0d51096c69f8..5a7589a90db1 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -182,6 +182,13 @@
 				interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
+			cps_thermal: thermal at 400078 {
+				compatible = "marvell,armada-cp110-thermal";
+				reg = <0x400078 0x4>,
+				      <0x400070 0x8>;
+				marvell,thermal-zone-name = "cp1_thermal_zone";
+			};
+
 			cps_syscon0: system-controller at 440000 {
 				compatible = "syscon", "simple-mfd";
 				reg = <0x440000 0x2000>;
-- 
2.11.0
