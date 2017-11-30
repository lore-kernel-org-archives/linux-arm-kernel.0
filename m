From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 30 Nov 2017 13:57:23 +0100
Subject: [PATCH v2 1/4] ARM: dts: armadillo800eva: Convert to named i2c-gpio
 bindings
In-Reply-To: <1512046646-15253-1-git-send-email-geert+renesas@glider.be>
References: <1512046646-15253-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1512046646-15253-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commits 7d29f509d2cfd807 ("dt-bindings: i2c: i2c-gpio: Add support for
named gpios") and 05c74778858d7d99 ("i2c: gpio: Add support for named
gpios in DT") introduced named i2c-gpio DT bindings, and deprecated the
more error-prone unnamed variant.

Switch to the new bindings, and add the missing GPIO_OPEN_DRAIN I/O
flags, which were implicitly assumed before.

The latter gets rid of the message:

    gpio-208 (?): enforced open drain please flag it properly in DT/ACPI DSDT/board file
    gpio-91 (?): enforced open drain please flag it properly in DT/ACPI DSDT/board file

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add GPIO_OPEN_DRAIN to the GPIO flags,
  - Reword.
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 8c85d3ee5f5e7bfd..527c60bafbcface0 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -138,9 +138,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <&pfc 208 GPIO_ACTIVE_HIGH /* sda */
-			 &pfc 91 GPIO_ACTIVE_HIGH /* scl */
-			>;
+		sda-gpios = <&pfc 208 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&pfc 91 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 		i2c-gpio,delay-us = <5>;
 	};
 
-- 
2.7.4
