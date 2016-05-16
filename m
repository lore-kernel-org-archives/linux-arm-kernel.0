From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 16 May 2016 10:26:48 +0200
Subject: [PATCH 2/2] ARM: dts: exynos: Enable CLKOUT on Exynos5410
In-Reply-To: <1463387208-9277-1-git-send-email-k.kozlowski@samsung.com>
References: <1463387208-9277-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1463387208-9277-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLKOUT (which control is provided by PMU) is necessary for some of
the drivers using this as a clock, e.g. usb3503 USB HUB on Odroid XU
board.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5410.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index e9564ab5b5d3..f1effd3f03c4 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -70,6 +70,9 @@
 		pmu_system_controller: system-controller at 10040000 {
 			compatible = "samsung,exynos5410-pmu", "syscon";
 			reg = <0x10040000 0x5000>;
+			clock-names = "clkout16";
+			clocks = <&fin_pll>;
+			#clock-cells = <1>;
 		};
 
 		clock: clock-controller at 10010000 {
-- 
1.9.1
