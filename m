From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 16 Aug 2013 13:19:38 +0530
Subject: [PATCH V2 4/4] ARM: dts: exynos5420: add audio clock controller
In-Reply-To: <1376639378-20707-1-git-send-email-padma.v@samsung.com>
References: <1376639378-20707-1-git-send-email-padma.v@samsung.com>
Message-ID: <1376639378-20707-5-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Bresticker <abrestic@chromium.org>

This adds device-tree bindings for the audio subsystem clock controller
on Exynos 5420.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 334f7b7..dde4cc2 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -15,6 +15,9 @@
 
 #include "exynos5.dtsi"
 #include "exynos5420-pinctrl.dtsi"
+
+#include <dt-bindings/clk/exynos-audss-clk.h>
+
 / {
 	compatible = "samsung,exynos5420";
 
@@ -65,6 +68,12 @@
 		#clock-cells = <1>;
 	};
 
+	clock_audss: audss-clock-controller at 3810000 {
+		compatible = "samsung,exynos5420-audss-clock";
+		reg = <0x03810000 0x0C>;
+		#clock-cells = <1>;
+	};
+
 	mct at 101C0000 {
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x101C0000 0x800>;
-- 
1.7.4.4
