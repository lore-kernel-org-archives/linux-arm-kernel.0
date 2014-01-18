From: kasimling@gmail.com (Alex Ling)
Date: Sat, 18 Jan 2014 22:24:42 +0800
Subject: [PATCH 1/2] ARM: dts: Add dwmmc host for TINY4412
Message-ID: <1390055084-27483-1-git-send-email-kasimling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dwmmc host node for to support eMMC on TINY4412 board.

Signed-off-by: Alex Ling <kasimling@gmail.com>
---
 arch/arm/boot/dts/exynos4412-tiny4412.dts |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index 0a98312..2c6bfe3 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -63,6 +63,25 @@
 		status = "okay";
 	};
 
+	mmc at 12550000 {
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
+		non-removable;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
+		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
+		pinctrl-names = "default";
+		status = "okay";
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <8>;
+		};
+	};
+
 	serial at 13800000 {
 		status = "okay";
 	};
-- 
1.7.9.5
