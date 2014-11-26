From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 26 Nov 2014 15:24:16 +0100
Subject: [PATCH v2 4/5] ARM: dts: exynos5420: Add clock for audss pinctrl
In-Reply-To: <1417011857-10419-1-git-send-email-k.kozlowski@samsung.com>
References: <1417011857-10419-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1417011857-10419-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl for audio subsystem needs 'mau_epll' clock to be enabled in
order to properly access memory during GPIO setup.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index ba686e40eac7..c0ca0da36ade 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -696,6 +696,9 @@
 	};
 
 	pinctrl at 03860000 {
+		clocks = <&clock CLK_MAU_EPLL>;
+		clock-names = "block";
+
 		gpz: gpz {
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
1.9.1
