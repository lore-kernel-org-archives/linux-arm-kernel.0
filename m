From: aballier@gentoo.org (Alexis Ballier)
Date: Wed, 12 Aug 2015 13:27:51 +0200
Subject: [PATCH] ARM: dts: exynos4412-odroidu3: Enable SPI1.
Message-ID: <1439378871-28117-1-git-send-email-aballier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI1 is available on IO Port #2 (as depicted on their website) in
PCB Revision 0.5 of Hardkernel Odroid U3 board.
The shield connects a 256KiB spi-nor flash on that bus.

Signed-off-by: Alexis Ballier <aballier@gentoo.org>
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 44684e5..37698e4 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -61,3 +61,10 @@
 		"Speakers", "SPKL",
 		"Speakers", "SPKR";
 };
+
+&spi_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_bus>;
+	cs-gpios = <&gpb 5 0>;
+	status = "okay";
+};
-- 
2.5.0
