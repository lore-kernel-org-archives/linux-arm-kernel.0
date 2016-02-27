From: carlo@caione.org (Carlo Caione)
Date: Sat, 27 Feb 2016 19:01:47 +0100
Subject: [PATCH v5 3/4] ARM: dts: meson8b: Add MMC nodes
In-Reply-To: <1456596108-1406-1-git-send-email-carlo@caione.org>
References: <1456596108-1406-1-git-send-email-carlo@caione.org>
Message-ID: <1456596108-1406-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Enable the MMC for the Meson8b platforms.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/boot/dts/meson8b-mxq.dts      |  8 ++++++++
 arch/arm/boot/dts/meson8b-odroidc1.dts |  8 ++++++++
 arch/arm/boot/dts/meson8b.dtsi         | 16 ++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/meson8b-mxq.dts
index c7fdaea..5c533a6 100644
--- a/arch/arm/boot/dts/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/meson8b-mxq.dts
@@ -60,6 +60,14 @@
 	};
 };
 
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "sdio_b";
+	pinctrl-0 = <&mmc0_sd_b_pins>;
+	meson,sd-port = <1>;
+	broken-cd;
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index e50f1a1..a060c84 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -71,6 +71,14 @@
 	};
 };
 
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "sdio_b";
+	pinctrl-0 = <&mmc0_sd_b_pins>;
+	meson,sd-port = <1>;
+	broken-cd;
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 8bad557..25d795c 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -187,6 +187,22 @@
 					function = "uart_ao";
 				};
 			};
+
+			mmc0_sd_b_pins: mmc0_sd_b {
+				mux {
+					groups = "sd_d1_b", "sd_d0_b", "sd_clk_b", "sd_cmd_b",
+						 "sd_d3_b", "sd_d2_b";
+					function = "sd_b";
+				};
+			};
+		};
+
+		mmc0: mmc at c1108c20 {
+			compatible = "amlogic,meson-mmc";
+			reg = <0xc1108c20 0x20>;
+			interrupts = <0 28 1>;
+			clocks = <&clkc CLKID_CLK81>;
+			status = "disabled";
 		};
 	};
 }; /* end of / */
-- 
1.9.1
