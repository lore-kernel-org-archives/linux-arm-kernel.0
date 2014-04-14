From: chanho61.park@samsung.com (Chanho Park)
Date: Mon, 14 Apr 2014 21:48:20 +0900
Subject: [PATCH 4/4] ARM: dts: exynos4412-trats2: enable usb nodes
In-Reply-To: <1397479700-15864-1-git-send-email-chanho61.park@samsung.com>
References: <1397479700-15864-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1397479700-15864-5-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables exynos_usbphy and hsotg device nodes.

Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kamil Debski <k.debski@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 9583563..a16db6c 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -665,6 +665,16 @@
 		};
 	};
 
+	exynos-usbphy at 125B0000 {
+		status = "okay";
+	};
+
+	hsotg at 12480000 {
+		vusb_d-supply = <&ldo15_reg>;
+		vusb_a-supply = <&ldo12_reg>;
+		status = "okay";
+	};
+
 	thermistor-ap at 0 {
 		compatible = "ntc,ncp15wb473";
 		pullup-uv = <1800000>;	 /* VCC_1.8V_AP */
-- 
1.8.3.2
