From: richard.kunze@web.de (Richard Kunze)
Date: Wed, 10 Dec 2014 19:40:41 +0100
Subject: [PATCH] ARM: dts: add gpio_poweroff support for Iomega ix2-200
Message-ID: <1418236841-15277-1-git-send-email-richard.kunze@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Iomega ix2-200 can be powered off via GPIO 0 pin 17,
this patch wires up the gpio-poweroff driver to do it.

Signed-off-by: Richard Kunze <richard.kunze@web.de>
---
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
index 05291f3..7aeddcd 100644
--- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
+++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
@@ -169,6 +169,10 @@
 			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 		};
 	};
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &nand {
-- 
1.9.1
