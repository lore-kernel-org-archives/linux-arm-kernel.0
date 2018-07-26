From: Akash_Gajjar@mentor.com (Akash Gajjar)
Date: Thu, 26 Jul 2018 12:21:46 +0530
Subject: [PATCH] arm64: dts: allwinner: activate spi flash on pine64 LTS board
In-Reply-To: <Akash_Gajjar@mentor.com>
References: <Akash_Gajjar@mentor.com>
Message-ID: <1532587906-5415-1-git-send-email-Akash_Gajjar@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has SPI flash. add spi flash support in device tree.
Tested on pine64 LTS.

Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
---
 .../arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index abe179d..9af07db 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -134,6 +134,18 @@
 	regulator-name = "vcc-wifi";
 };
 
+&spi0  {
+	status = "okay";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128", "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.7.4
