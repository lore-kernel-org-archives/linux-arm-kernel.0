From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 19 Aug 2014 15:03:02 +0100
Subject: [PATCH] ARM: dts: sun6i: Add #address-cells & #size-cells to i2c node
Message-ID: <1408456982-27021-1-git-send-email-ijc@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:
  DTC     arch/arm/boot/dts/sun6i-a31-hummingbird.dtb
Warning (reg_format): "reg" property in /soc at 01c00000/i2c at 01c2b400/rtc at 51 has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc at 01c00000/i2c at 01c2b400/rtc at 51
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc at 01c00000/i2c at 01c2b400/rtc at 51

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 44b07e5..5bc769f 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -680,6 +680,8 @@
 			clock-frequency = <100000>;
 			resets = <&apb2_rst 2>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		i2c3: i2c at 01c2b800 {
-- 
2.0.1
