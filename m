From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 02 Apr 2015 17:34:36 +0900
Subject: [PATCH 5/6] arm64: dts: exynos: Add UART3 dt node for Exynos5433 SoC
In-Reply-To: <1427963677-32661-1-git-send-email-cw00.choi@samsung.com>
References: <1427963677-32661-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1427963677-32661-6-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Beomho Seo <beomho.seo@samsung.com>

This patch adds the UART3 devicetree node for Exynos5433 SoC. The UART3 device
is included in AUD_DOMAIN.

Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  7 +++++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
index 49be038..f2d7a39 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
@@ -83,6 +83,13 @@
 		samsung,pin-pud = <1>;
 		samsung,pin-drv = <0>;
 	};
+
+	uart_aud_bus: uart-aud-bus {
+		samsung,pins = "gpz1-3", "gpz1-2", "gpz1-1", "gpz1-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
 };
 
 &pinctrl_cpif {
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index baeec299..f179c60 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -475,6 +475,18 @@
 			status = "disabled";
 		};
 
+		serial_3: serial at 11460000 {
+			compatible = "samsung,exynos5433-uart";
+			reg = <0x11460000 0x100>;
+			interrupts = <0 67 0>;
+			clocks = <&cmu_aud CLK_PCLK_AUD_UART>,
+				 <&cmu_aud CLK_SCLK_AUD_UART>;
+			clock-names = "uart", "clk_uart_baud0";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart_aud_bus>;
+			status = "disabled";
+		};
+
 		i2s0: i2s0 at 11440000 {
 			compatible = "samsung,exynos7-i2s";
 			reg = <0x11440000 0x100>;
-- 
1.8.5.5
