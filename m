From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 May 2014 17:47:45 +0200
Subject: [PATCH 1/2] ARM: sunxi: Add fixed 3V regulator
Message-ID: <1400600866-29938-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few boards we've seen have a fixed 3V regulator. Add this one on the common
DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index 026bd83f078f..3d021efd1a38 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -73,6 +73,13 @@
 		status = "disabled";
 	};
 
+	reg_vcc3v0: vcc3v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v0";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
 	reg_vcc3v3: vcc3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3";
-- 
1.9.3
