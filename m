From: rodrigo@tjader.xyz (=?UTF-8?q?Rodrigo=20Exterck=C3=B6tter=20Tj=C3=A4der?=)
Date: Wed, 19 Sep 2018 11:18:13 -0300
Subject: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable eMMC.
Message-ID: <20180919141815.18737-1-rodrigo@tjader.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copied snippet from A64-TERES I.

Signed-off-by: Rodrigo Exterck?tter Tj?der <rodrigo@tjader.xyz>
---
 .../arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 657f58def54c..5245de3a1f35 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -128,6 +128,17 @@
 	};
 };
 
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_dcdc1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.18.0
