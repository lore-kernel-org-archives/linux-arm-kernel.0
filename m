From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 15 May 2016 22:13:54 +0200
Subject: [PATCH v4 13/22] ARM: dts: exynos: Enable UART3 on Exynos5410
In-Reply-To: <1463343243-26429-1-git-send-email-krzk@kernel.org>
References: <1463343243-26429-1-git-send-email-krzk@kernel.org>
Message-ID: <1463343243-26429-14-git-send-email-krzk@kernel.org>
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
index c8f2e4881667..0edcd7022293 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -215,7 +215,8 @@
 };
 
 &serial_3 {
-	status = "disabled";
+	clocks = <&clock CLK_UART3>, <&clock CLK_SCLK_UART3>;
+	clock-names = "uart", "clk_uart_baud0";
 };
 
 &sromc {
-- 
2.5.0
