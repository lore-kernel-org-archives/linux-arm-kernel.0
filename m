From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 26 Sep 2017 09:22:29 +0200
Subject: [PATCH v3 09/14] ARM: dts: sun8i: orangepi-plus: Fix node with unit
 name and no reg property
In-Reply-To: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
Message-ID: <20170926072234.27481-10-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the warning "xxx has a unit name, but no reg property" by
removing "@0" from such node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index 331ed683ac62..119732505844 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -114,7 +114,7 @@
 };
 
 &pio {
-	usb3_vbus_pin_a: usb3_vbus_pin at 0 {
+	usb3_vbus_pin_a: usb3_vbus_pin {
 		pins = "PG11";
 		function = "gpio_out";
 	};
-- 
2.13.5
