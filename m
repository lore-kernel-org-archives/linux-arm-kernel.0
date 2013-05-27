From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Mon, 27 May 2013 17:55:26 +0200
Subject: [PATCH] ARM: kirkwood: add i2c-gpio controller for km_kirkwood
Message-ID: <1369670126-27284-1-git-send-email-valentin.longchamp@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This controller is used to access the reset management FPGA of the
km_kirkwood boards.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
index 5bbd054..64ee738 100644
--- a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
+++ b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
@@ -42,4 +42,11 @@
 			chip-delay = <25>;
 		};
 	};
+
+	i2c at 0 {
+		compatible = "i2c-gpio";
+		gpios = < &gpio0 8 0		/* sda */
+			&gpio0 9 0 >;		/* scl */
+		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+	};
 };
-- 
1.8.0.1
