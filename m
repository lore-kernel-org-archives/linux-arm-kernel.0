From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 19 Jul 2018 18:00:47 +0200
Subject: [RFT 07/10] ARM: dts: s5pv210: Switch to S5Pv210 specific pinctrl
 wakeup compatible
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Message-ID: <20180719160050.22566-8-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pin controller block of S5Pv210 for handling external wakeup
interrupts is different than in newer designs (Exynos).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 67358562a6ea..75f454a210d6 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -120,7 +120,7 @@
 			interrupts = <30>;
 
 			wakeup-interrupt-controller {
-				compatible = "samsung,exynos4210-wakeup-eint";
+				compatible = "samsung,s5pv210-wakeup-eint";
 				interrupts = <16>;
 				interrupt-parent = <&vic0>;
 			};
-- 
2.14.1
