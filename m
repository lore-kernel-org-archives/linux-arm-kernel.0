From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 10 Jun 2017 00:20:39 +0200
Subject: [PATCH] ARM: dts: meson8: fix the IR receiver pins
Message-ID: <20170609222039.25191-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IR receiver pins are currently defined in the CBUS pin-controller.
However the pins are in the AO region, which is controlled by the AOBUS
pin-controller. Move the pins to pinctrl_aobus so they can actually be
used.

Fixes: b60e1157d8fa ("ARM: dts: amlogic: Split pinctrl device for Meson8 / Meson8b")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 9b0b3ddbb17e..e4f7357b4b31 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -116,6 +116,13 @@
 				function = "i2c_mst_ao";
 			};
 		};
+
+		ir_recv_pins: remote {
+			mux {
+				groups = "remote_input";
+				function = "remote";
+			};
+		};
 	};
 };
 
@@ -151,13 +158,6 @@
 			};
 		};
 
-		ir_recv_pins: remote {
-			mux {
-				groups = "remote_input";
-				function = "remote";
-			};
-		};
-
 		eth_pins: ethernet {
 			mux {
 				groups = "eth_tx_clk_50m", "eth_tx_en",
-- 
2.13.1
