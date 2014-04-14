From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 16:34:13 +0200
Subject: [PATCH v2 3/5] ARM: mvebu: add Device Tree description of AHCI
 interfaces on Armada 38x
In-Reply-To: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397486055-16303-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x processors contain two AHCI compatible
interfaces. This commit adds the Device Tree description of those
interfaces at the SoC level, and also enables them on the Armada 385
DB platform, which allows access to both interfaces through SATA
ports.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db.dts |  8 ++++++++
 arch/arm/boot/dts/armada-38x.dtsi   | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
index 6828d77..bdde8ff 100644
--- a/arch/arm/boot/dts/armada-385-db.dts
+++ b/arch/arm/boot/dts/armada-385-db.dts
@@ -81,6 +81,14 @@
 				};
 			};
 
+			sata at a8000 {
+				status = "okay";
+			};
+
+			sata at e0000 {
+				status = "okay";
+			};
+
 			flash at d0000 {
 				status = "okay";
 				num-cs = <1>;
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index a064f59..634a020 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -338,6 +338,22 @@
 				reg = <0x72004 0x4>;
 			};
 
+			sata at a8000 {
+				compatible = "marvell,armada-380-ahci";
+				reg = <0xa8000 0x2000>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 15>;
+				status = "disabled";
+			};
+
+			sata at e0000 {
+				compatible = "marvell,armada-380-ahci";
+				reg = <0xe0000 0x2000>;
+				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 30>;
+				status = "disabled";
+			};
+
 			coredivclk: clock at e4250 {
 				compatible = "marvell,armada-380-corediv-clock";
 				reg = <0xe4250 0xc>;
-- 
1.8.3.2
