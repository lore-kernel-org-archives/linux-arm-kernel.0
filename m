From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue, 19 Apr 2016 08:56:46 +0200
Subject: [PATCH] ARM: BCM5301X: Add DT entry for SPI controller and NOR flash
Message-ID: <1461049006-22818-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Controller is present on every BCM4708* board but only few devices have
serial flash attached so mark it as disabled by default.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts  |  4 ++++
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts |  4 ++++
 arch/arm/boot/dts/bcm5301x.dtsi               | 14 ++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
index c973f768..1c7e53d 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
@@ -59,3 +59,7 @@
 &uart0 {
 	status = "okay";
 };
+
+&spi_nor {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 4d610ff..8b0c440 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -122,3 +122,7 @@
 &uart0 {
 	status = "okay";
 };
+
+&spi_nor {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 9c06d91..7d4d29b 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -225,6 +225,20 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 		};
+
+		spi at 29000 {
+			reg = <0x00029000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			spi_nor: spi-nor at 0 {
+				compatible = "jedec,spi-nor";
+				reg = <0>;
+				spi-max-frequency = <20000000>;
+				linux,part-probe = "ofpart", "bcm47xxpart";
+				status = "disabled";
+			};
+		};
 	};
 
 	lcpll0: lcpll0 at 1800c100 {
-- 
1.8.4.5
