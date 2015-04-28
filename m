From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 28 Apr 2015 13:59:42 +0300
Subject: [PATCH 2/4] ARM: digicolor: add i2c master controller support
In-Reply-To: <cover.1430217994.git.baruch@tkos.co.il>
References: <cover.1430217994.git.baruch@tkos.co.il>
Message-ID: <67e83482d633d141bd5cd74905f50c0b1a67eebf.1430217994.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/cx92755.dtsi        | 11 +++++++++++
 arch/arm/boot/dts/cx92755_equinox.dts |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/cx92755.dtsi b/arch/arm/boot/dts/cx92755.dtsi
index a2f5ffe1e8a8..af333261d046 100644
--- a/arch/arm/boot/dts/cx92755.dtsi
+++ b/arch/arm/boot/dts/cx92755.dtsi
@@ -116,4 +116,15 @@
 		interrupts = <46>;
 		status = "disabled";
 	};
+
+	i2c: i2c at f0000120 {
+		compatible = "cnxt,cx92755-i2c";
+		reg = <0xf0000120 0x10>;
+		interrupts = <28>;
+		clocks = <&main_clk>;
+		clock-frequency = <100000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/boot/dts/cx92755_equinox.dts b/arch/arm/boot/dts/cx92755_equinox.dts
index f33bf5635d47..90d52cc416dc 100644
--- a/arch/arm/boot/dts/cx92755_equinox.dts
+++ b/arch/arm/boot/dts/cx92755_equinox.dts
@@ -72,3 +72,7 @@
 &uart0 {
 	status = "okay";
 };
+
+&i2c {
+	status = "okay";
+};
-- 
2.1.4
