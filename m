From: hramrach@gmail.com (Michal Suchanek)
Date: 3 Jun 2015 21:26:39 -0000
Subject: [PATCH 01/11] ARM: dt: Add SPI CS on Samsung Snow board.
In-Reply-To: <cover.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
Message-ID: <d47abe28c751b54b839d9340269a2c06a6e23a6c.1433364398.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although there is only one choice of chipselect it is necessary to
specify it. The driver cannot claim the gpio otherwise.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 1eca97e..1fa72cf 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -687,9 +687,10 @@
 };
 
 &spi_1 {
-	status = "okay";
 	samsung,spi-src-clk = <0>;
 	num-cs = <1>;
+	cs-gpios = <&gpa2 5 0>;
+	status = "okay";
 };
 
 &usbdrd_dwc3 {
-- 
2.1.4
