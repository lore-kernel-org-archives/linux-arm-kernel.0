From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  8 May 2016 21:06:03 +0200
Subject: [PATCH v2 18/22] ARM: dts: exynos: Enable UART3 on Exynos5410
In-Reply-To: <1462734367-5619-1-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
Message-ID: <1462734367-5619-19-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like other Exynos5 family SoCs, this one has four UARTs. Configure
clocks for UART3 and enable it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index c0540eb76271..62dc3b4aef93 100644
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
