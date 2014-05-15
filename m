From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 May 2014 12:17:39 +0200
Subject: [PATCH v6 14/17] ARM: mvebu: add Device Tree description of xHCI
 controllers on Armada 38x
In-Reply-To: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
References: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1400149062-32661-15-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x SoCs contains two xHCI controllers. This commit
adds the Device Tree description of those interfaces at the SoC level,
and also enables the two USB3 ports on the Armada 385 DB platform and
one USB3 port on the Armada 385 RD platform.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db.dts |  8 ++++++++
 arch/arm/boot/dts/armada-385-rd.dts |  4 ++++
 arch/arm/boot/dts/armada-38x.dtsi   | 17 +++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
index 6828d77696a6..d5db1466da82 100644
--- a/arch/arm/boot/dts/armada-385-db.dts
+++ b/arch/arm/boot/dts/armada-385-db.dts
@@ -101,6 +101,14 @@
 					reg = <0x1000000 0x3f000000>;
 				};
 			};
+
+			usb3 at f0000 {
+				status = "okay";
+			};
+
+			usb3 at f8000 {
+				status = "okay";
+			};
 		};
 
 		pcie-controller {
diff --git a/arch/arm/boot/dts/armada-385-rd.dts b/arch/arm/boot/dts/armada-385-rd.dts
index 45250c88814b..a505fe94ff37 100644
--- a/arch/arm/boot/dts/armada-385-rd.dts
+++ b/arch/arm/boot/dts/armada-385-rd.dts
@@ -77,6 +77,10 @@
 					reg = <1>;
 				};
 			};
+
+			usb3 at f0000 {
+				status = "okay";
+			};
 		};
 
 		pcie-controller {
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index a064f59da02d..6f97f3d7fb15 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -355,6 +355,23 @@
 				clocks = <&coredivclk 0>;
 				status = "disabled";
 			};
+
+			usb3 at f0000 {
+				compatible = "marvell,armada-380-xhci";
+				reg = <0xf0000 0x4000>,<0xf4000 0x4000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 9>;
+				status = "disabled";
+			};
+
+			usb3 at f8000 {
+				compatible = "marvell,armada-380-xhci";
+				reg = <0xf8000 0x4000>,<0xfc000 0x4000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 10>;
+				status = "disabled";
+			};
+
 		};
 	};
 
-- 
1.8.1.2
