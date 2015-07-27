From: hramrach@gmail.com (Michal Suchanek)
Date: 27 Jul 2015 20:11:31 -0000
Subject: [PATCH v2] ARM: dts: Add SPI CS on exynos5250-snow
Message-ID: <a5054dfad3d48c582b062b0536125c9bcff41f31.1438027526.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although there is only one choice of chipselect it is necessary to
specify it. The driver cannot claim the gpio otherwise.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>

--
v2
 - don't move unrelated line
---
 arch/arm/boot/dts/exynos5250-snow.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index b7f4122..62be08a 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -688,6 +688,7 @@
 	status = "okay";
 	samsung,spi-src-clk = <0>;
 	num-cs = <1>;
+	cs-gpios = <&gpa2 5 0>;
 };
 
 &usbdrd_dwc3 {
-- 
2.1.4
