From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 26 Jul 2018 01:35:22 +0100
Subject: [PATCH v2 08/18] arm64: dts: allwinner: a64: Orange Pi Win: Add SDIO
 node
In-Reply-To: <20180726003532.18751-1-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
Message-ID: <20180726003532.18751-9-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Samuel Holland <samuel@sholland.org>

The Orange Pi Win features a soldered WiFi chip on the board, connected
via the SDIO interface. Add the required DT nodes.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 55eea0b077d0..a368f51399e6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -94,6 +94,11 @@
 		gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* PD7 */
 		status = "okay";
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
+	};
 };
 
 &ehci1 {
@@ -126,6 +131,17 @@
 	status = "okay";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_dldo2>;
+	vqmmc-supply = <&reg_dldo4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
-- 
2.14.4
