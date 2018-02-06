From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  6 Feb 2018 12:48:58 +0800
Subject: [PATCH v2 03/10] ARM: sunxi: h3/h5: Add r_i2c pinmux node
In-Reply-To: <20180206044905.30508-1-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io>
Message-ID: <20180206044905.30508-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

H3/H5 SoCs contain an I2C controller optionally available
on the PL0 and PL1 pins. This patch adds pinmux configuration
for this controller.

Signed-off-by: Ondrej Jirman <megous@megous.com>
[Icenowy: change commit message, node name and function name]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v2:
- Added Chen-Yu's Review tag.

 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 7a83b15225c7..fc602aed60a6 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -731,6 +731,11 @@
 				pins = "PL11";
 				function = "s_cir_rx";
 			};
+
+			r_i2c_pins: r-i2c {
+				pins = "PL0", "PL1";
+				function = "s_i2c";
+			};
 		};
 	};
 };
-- 
2.15.1
