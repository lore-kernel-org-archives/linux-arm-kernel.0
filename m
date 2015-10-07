From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 07 Oct 2015 09:30:07 +0900
Subject: [RFT 3/3] ARM: dts: Fix usb3503 probe by enabling phy on
 exynos5250-arndale
In-Reply-To: <1444177807-15524-1-git-send-email-k.kozlowski@samsung.com>
References: <1444177807-15524-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1444177807-15524-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Arndale board (unlike Odroid U3) the USB3503 hub controller is
connected in phy mode (not through I2C). For successful probe it needs
to get reference to proper phy and enable it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reported-by: Kevin Hilman <khilman@kernel.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: riku.voipio at linaro.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index c000532c1444..e213f31acbf3 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -114,6 +114,8 @@
 
 		reset-gpios = <&gpx3 5 GPIO_ACTIVE_LOW>;
 		connect-gpios = <&gpd1 7 GPIO_ACTIVE_LOW>;
+		phys = <&usb2_phy_gen 3>;
+		phy-names = "usb2-phy";
 	};
 };
 
-- 
1.9.1
