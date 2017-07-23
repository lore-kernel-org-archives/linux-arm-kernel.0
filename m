From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 23 Jul 2017 18:27:42 +0800
Subject: [PATCH 03/10] ARM: sunxi: h3/h5: Add r_i2c pinmux node
In-Reply-To: <20170723102749.17323-1-icenowy@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
Message-ID: <20170723102749.17323-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

H3/H5 SoCs contain an I2C controller optionally available
on the PL0 and PL1 pins. This patch adds pinmux configuration
for this controller.

Signed-off-by: Ondrej Jirman <megous@megous.com>
[Icenowy: change commit message and node name]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 6f2162608006..b240099bc865 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -639,6 +639,11 @@
 				pins = "PL11";
 				function = "s_cir_rx";
 			};
+
+			r_i2c_pins: r-i2c {
+				pins = "PL0", "PL1";
+				function = "s_twi";
+			};
 		};
 	};
 };
-- 
2.13.0
