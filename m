From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  3 Mar 2015 11:52:01 +0800
Subject: [PATCH] ARM: dts: sun6i: hummingbird: Enable IR receiver
Message-ID: <1425354721-3321-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 Hummingbird has an IR receiver.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Tested with an NEC protocol remote for an Android based set-top box.

---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 8b61b1b342e0..65ddaf4c72d2 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -106,6 +106,12 @@
 	};
 };
 
+&ir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir_pins_a>;
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_hummingbird>;
-- 
2.1.4
