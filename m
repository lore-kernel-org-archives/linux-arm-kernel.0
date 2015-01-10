From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Sat, 10 Jan 2015 08:41:36 +0530
Subject: [PATCH 2/2] arm: dts: disable CCI on exynos420 based arndale-octa
In-Reply-To: <1420859496-27533-1-git-send-email-a.kesavan@samsung.com>
References: <1420859496-27533-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1420859496-27533-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arndale-octa board was giving "imprecise external aborts" during
boot-up with MCPM enabled. CCI enablement of the boot cluster was found
to be the cause of these aborts (possibly because the secure f/w was not
allowing it). Hence, disable CCI for the arndale-octa board.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Tested-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Tyler Baker <tyler.baker@linaro.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 4 ++++
 arch/arm/boot/dts/exynos5420.dtsi             | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index aa7a7d7..db2c1c4 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -372,3 +372,7 @@
 &usbdrd_dwc3_1 {
 	dr_mode = "host";
 };
+
+&cci {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 517e50f..0a82ae7 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -120,7 +120,7 @@
 		};
 	};
 
-	cci at 10d20000 {
+	cci: cci at 10d20000 {
 		compatible = "arm,cci-400";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.2.0
