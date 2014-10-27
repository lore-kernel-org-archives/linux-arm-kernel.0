From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Oct 2014 15:35:58 +0100
Subject: [PATCH] ARM: dts: exynos4412-trats: Add micro SD card SDHCI node
Message-ID: <1414420558-5376-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SDHCI node for supporting the micro SD card. On Trats2 board the
SDHCI does not use sd2_cd pins (gpk2-2) for card detect but gpx3-4
instead.

Power is supplied from LDO21 regulator which in off state is controlled
by external GPIO pin.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index a5aa52bba72c..2e5d0fdf8362 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -603,6 +603,17 @@
 		cap-mmc-highspeed;
 	};
 
+	/* FIXME: suspend fails... */
+	sdhci at 12530000 {
+		bus-width = <4>;
+		cd-gpios = <&gpx3 4 0>;
+		cd-inverted;
+		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4>;
+		pinctrl-names = "default";
+		vmmc-supply = <&ldo21_reg>;
+		status = "okay";
+	};
+
 	serial at 13800000 {
 		status = "okay";
 	};
-- 
1.9.1
