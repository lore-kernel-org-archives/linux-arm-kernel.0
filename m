From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 19 Nov 2012 15:45:29 +0100
Subject: [PATCH 5/5] ARM: dts: exynos4210-trats: Add node for touchscreen
In-Reply-To: <1353336329-20818-1-git-send-email-t.figa@samsung.com>
References: <1353336329-20818-1-git-send-email-t.figa@samsung.com>
Message-ID: <1353336329-20818-6-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a device tree node for the Melfas MMS114-controlled
touchscreen present on Samsung Trats board.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 86ff800..4a4bbac 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -114,6 +114,17 @@
 		pinctrl-0 = <&i2c3_bus>;
 		pinctrl-names = "default";
 		status = "okay";
+
+		mms114-touchscreen at 48 {
+			compatible = "melfas,mms114";
+			reg = <0x48>;
+			interrupt-parent = <&gpx0>;
+			interrupts = <4 2>;
+			x-size = <720>;
+			y-size = <1280>;
+			avdd-supply = <&tsp_reg>;
+			vdd-supply = <&tsp_reg>;
+		};
 	};
 
 	i2c at 138B0000 {
-- 
1.8.0
