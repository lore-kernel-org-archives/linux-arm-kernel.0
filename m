From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 01 Sep 2014 17:26:01 +0200
Subject: [PATCH 2/3] ARM: dts: exynos3250: Add CMU node for DMC domain clocks
In-Reply-To: <1409585162-10523-1-git-send-email-k.kozlowski@samsung.com>
References: <1409585162-10523-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1409585162-10523-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CMU (Clock Management Unit) node for DMC (Dynamic Memory Controller)
domain clocks on Exynos3250.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 429a6c6cfcf9..8c3a9cc0a4d1 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -163,6 +163,12 @@
 			#clock-cells = <1>;
 		};
 
+		cmu_dmc: clock-controller at 105C0000 {
+			compatible = "samsung,exynos3250-cmu-dmc";
+			reg = <0x105C0000 0x2000>;
+			#clock-cells = <1>;
+		};
+
 		rtc: rtc at 10070000 {
 			compatible = "samsung,exynos3250-rtc";
 			reg = <0x10070000 0x100>;
-- 
1.9.1
