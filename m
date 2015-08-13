From: aballier@gentoo.org (Alexis Ballier)
Date: Thu, 13 Aug 2015 11:06:53 +0200
Subject: [PATCH v2] ARM: dts: exynos4412-odroidu3: Enable SPI1.
Message-ID: <1439456813-4918-1-git-send-email-aballier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI1 is available on IO Port #2 (as depicted on their website) in
PCB Revision 0.5 of Hardkernel Odroid U3 board.
The shield connects a 256KiB spi-nor flash on that bus.

Signed-off-by: Alexis Ballier <aballier@gentoo.org>

---

Changes in v2: Use GPIO_ACTIVE_HIGH (Krzysztof Kozlowski)

 arch/arm/boot/dts/exynos4412-odroidu3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 44684e5..8632f35 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 #include "exynos4412-odroid-common.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Hardkernel ODROID-U3 board based on Exynos4412";
@@ -61,3 +62,10 @@
 		"Speakers", "SPKL",
 		"Speakers", "SPKR";
 };
+
+&spi_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_bus>;
+	cs-gpios = <&gpb 5 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
-- 
2.5.0
