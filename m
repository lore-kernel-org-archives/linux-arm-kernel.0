From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:53 +0100
Subject: [PATCH 58/61] ARM: dts: armadillo800eva: Convert to named i2c-gpio
 bindings
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <4f1cfdc250900e275a3f2341d57ba1c7ce41188a.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

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
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 1788e186a512..03b00d87b39b 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -131,9 +131,8 @@
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
2.11.0
