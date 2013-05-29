From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 29 May 2013 19:32:22 +0200
Subject: [PATCH] ARM: ux500: cut chip-select GPIOs from SSP device
Message-ID: <1369848742-10451-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

What GPIO pin is used with which device on the SSP/SPI bus
is as board-specific as it gets, so it does not belong here
in the core SoC file, and it is disabled so it doesn't hurt
to delete this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index b4b542b..12f36d4 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -589,11 +589,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-
-			// Add one of these for each child device
-			cs-gpios = <&gpio0 31 0x4 &gpio4 14 0x4 &gpio4 16 0x4
-				    &gpio6 22 0x4 &gpio7 0 0x4>;
-
 		};
 
 		uart at 80120000 {
-- 
1.7.11.3
