From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 19 Feb 2018 09:16:17 +0100
Subject: [PATCH 2/2] arm64: dts: rockchip: add a standalone version of the
 rk3399 sapphire
In-Reply-To: <3840224.sEPfbROKII@phil>
References: <CAAMcf8CY1m+998+GpD2wOfAZb=oZNkL2GqYu_o5piGEh76uoYw@mail.gmail.com>
 <3840224.sEPfbROKII@phil>
Message-ID: <7102557.xWtZfjvKIZ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the sapphire board is a system-on-module and mostly used with the
excavator baseboard, it is also possible to use it standalone without
any base. So add a board-variant for this type.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/arm/rockchip.txt |  4 ++++
 arch/arm64/boot/dts/rockchip/Makefile              |  1 +
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dts   | 12 ++++++++++++
 3 files changed, 17 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 9a3e98356b1e..1c1d62d03c4f 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -185,6 +185,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "rockchip,rk3399-evb", "rockchip,rk3399";
 
+- Rockchip RK3399 Sapphire board standalone:
+    Required root node properties:
+      - compatible = "rockchip,rk3399-sapphire", "rockchip,rk3399";
+
 - Rockchip RK3399 Sapphire Excavator board:
     Required root node properties:
       - compatible = "rockchip,rk3399-sapphire-excavator", "rockchip,rk3399";
diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 1e57f87f30c4..48a83f882947 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -12,4 +12,5 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dts b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dts
new file mode 100644
index 000000000000..5a58060447cf
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd.
+ */
+
+/dts-v1/;
+#include "rk3399-sapphire.dtsi"
+
+/ {
+	model = "Sapphire-RK3399 Board";
+	compatible = "rockchip,rk3399-sapphire", "rockchip,rk3399";
+};
-- 
2.15.1
