From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 23 Sep 2018 13:38:07 +0200
Subject: [PATCH v4 2/2] ARM: dts: rockchip: add rk3288-based Tinker board S
In-Reply-To: <20180923113807.11558-1-heiko@sntech.de>
References: <20180923113807.11558-1-heiko@sntech.de>
Message-ID: <20180923113807.11558-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Summers <beagleboard@davidjohnsummers.uk>

Add the actual dts for the tinker board S, which brings its own emmc
device, not therefore not requiring an sd-card to boot.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/arm/rockchip.txt      |  4 +++
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/rk3288-tinker-s.dts         | 26 +++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-tinker-s.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 6bb80f2b7c5d..624253fee7d5 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -17,6 +17,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "asus,rk3288-tinker", "rockchip,rk3288";
 
+- Asus Tinker board S
+    Required root node properties:
+      - compatible = "asus,rk3288-tinker-s", "rockchip,rk3288";
+
 - Kylin RK3036 board:
     Required root node properties:
       - compatible = "rockchip,kylin-rk3036", "rockchip,rk3036";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de87c33..dc86080c60e3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -864,6 +864,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3288-r89.dtb \
 	rk3288-rock2-square.dtb \
 	rk3288-tinker.dtb \
+	rk3288-tinker-s.dtb \
 	rk3288-veyron-brain.dtb \
 	rk3288-veyron-jaq.dtb \
 	rk3288-veyron-jerry.dtb \
diff --git a/arch/arm/boot/dts/rk3288-tinker-s.dts b/arch/arm/boot/dts/rk3288-tinker-s.dts
new file mode 100644
index 000000000000..37093922b482
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-tinker-s.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
+ */
+
+/dts-v1/;
+
+#include "rk3288-tinker.dtsi"
+
+/ {
+	model = "Rockchip RK3288 Asus Tinker Board S";
+	compatible = "asus,rk3288-tinker-s", "rockchip,rk3288";
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	disable-wp;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
+	max-frequency = <150000000>;
+	mmc-hs200-1_8v;
+	mmc-ddr-1_8v;
+	status = "okay";
+};
-- 
2.18.0
