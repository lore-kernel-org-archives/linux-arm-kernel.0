From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 30 Nov 2017 13:57:25 +0100
Subject: [PATCH v2 3/4] ARM: dts: koelsch: Convert to named i2c-gpio bindings
In-Reply-To: <1512046646-15253-1-git-send-email-geert+renesas@glider.be>
References: <1512046646-15253-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1512046646-15253-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commits 7d29f509d2cfd807 ("dt-bindings: i2c: i2c-gpio: Add support for
named gpios") and 05c74778858d7d99 ("i2c: gpio: Add support for named
gpios in DT") introduced named i2c-gpio DT bindings, and deprecated the
more error-prone unnamed variant.

Switch to the new bindings, and add the missing GPIO_OPEN_DRAIN I/O
flags, which were implicitly assumed before.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index fac9cdea49650591..a50924d12b6f37d5 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -312,9 +312,8 @@
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
 		status = "disabled";
-		gpios = <&gpio7 16 GPIO_ACTIVE_HIGH /* sda */
-			 &gpio7 15 GPIO_ACTIVE_HIGH /* scl */
-			>;
+		sda-gpios = <&gpio7 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpio7 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 		i2c-gpio,delay-us = <5>;
 	};
 
-- 
2.7.4
