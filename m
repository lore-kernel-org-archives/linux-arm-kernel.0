From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 17 Sep 2014 00:04:45 +0800
Subject: [PATCH v4 1/2] ARM: dts: sunxi: Add fixed 5V regulator
In-Reply-To: <1410883486-22888-1-git-send-email-wens@csie.org>
References: <1410883486-22888-1-git-send-email-wens@csie.org>
Message-ID: <1410883486-22888-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most if not all boards we've seen have a fixed 5V regulator, which is
the main power supply and/or fixed output of the PMIC.

Add this one to the common regulators DTSI.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index 3d021ef..c9c5b10 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -86,4 +86,11 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	reg_vcc5v0: vcc5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
 };
-- 
2.1.0
