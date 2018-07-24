From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 24 Jul 2018 09:15:49 +0800
Subject: [PATCH 1/3] arm64: allwinner: dts: h6: add Pine H64 model B
In-Reply-To: <20180724011551.49603-1-icenowy@aosc.io>
References: <20180724011551.49603-1-icenowy@aosc.io>
Message-ID: <20180724011551.49603-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pine H64 model B is another variant of Pine H64 by Pine64. It features a
smaller board footprint (of RPi size) and drops PCIe. It also have WLAN
on board (rather than via expansion connector on the original model A)
and some LED changes.

Add an initial device tree for it. Only LED difference is considered
now, as functionalities related to other changes are still not available
now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-h6-pine-h64-model-b.dts  | 20 +++++++++++++++++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  5 +++--
 3 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 9ffa7a038791..330b5fb3715b 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -16,3 +16,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
new file mode 100644
index 000000000000..d0fcc25efb00
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#include "sun50i-h6-pine-h64.dts"
+
+/ {
+	model = "Pine H64 Model B";
+	compatible = "pine64,pine-h64-model-b", "pine64,pine-h64",
+		     "allwinner,sun50i-h6";
+
+	leds {
+		/delete-node/ heartbeat;
+
+		status {
+			label = "pine-h64:red:status";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index ceffc40810ee..a85867f8b684 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -10,8 +10,9 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Pine H64";
-	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
+	model = "Pine H64 Model A";
+	compatible = "pine64,pine-h64-model-a", "pine64,pine-h64",
+		     "allwinner,sun50i-h6";
 
 	aliases {
 		serial0 = &uart0;
-- 
2.18.0
