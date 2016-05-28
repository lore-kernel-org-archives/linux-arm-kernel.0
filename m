From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 28 May 2016 11:54:24 +0200
Subject: [PATCH v5 13/22] ARM: dts: exynos: Enable UART3 on Exynos5410
In-Reply-To: <1464429273-23457-1-git-send-email-krzk@kernel.org>
References: <1464429273-23457-1-git-send-email-krzk@kernel.org>
Message-ID: <1464429273-23457-14-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like other Exynos5 family SoCs, this one has four UARTs. Configure
clocks for UART3 and enable it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos5410.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 0d555c5b7311..a81a03408a0a 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -218,7 +218,8 @@
 };
 
 &serial_3 {
-	status = "disabled";
+	clocks = <&clock CLK_UART3>, <&clock CLK_SCLK_UART3>;
+	clock-names = "uart", "clk_uart_baud0";
 };
 
 &sromc {
-- 
2.7.4
