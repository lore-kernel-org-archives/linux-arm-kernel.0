From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 16 Mar 2018 22:02:15 +0800
Subject: [PATCH v4 9/9] arm64: allwinner: h6: add support for Pine H64 board
In-Reply-To: <20180316140215.28663-1-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
Message-ID: <20180316140215.28663-10-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pine H64 is an Allwinner H6-based SBC from Pine64, with the following
features:

- 1GiB/2GiB/4GiB LPDDR3 DRAM (in 4GiB situation only 3GiB is
accessible)
- AXP805 PMIC
- Raspberry-Pi-compatible GPIO header, "Euler" GPIO header (not
compatible with the "Euler" on Pine A64) and "Expansion" pin header
- 2 USB 2.0 ports and 1 USB 3.0 ports
- Audio jack
- MicroSD slot and eMMC module slot
- on-board SPI NOR flash
- 1Gbps Ethernet port (via RTL8211E PHY)
- HDMI port

Adds initial support for it, including the UART on the Expansion pin
header.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
---
No changes in v4.

Changes in v3:
- SPDX license identifier fix.
- Add Andre's Reviewed-by/Tested-by tags.

Changes in v2:
- Switch to SPDX license identifier.

 arch/arm64/boot/dts/allwinner/Makefile             |  1 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 29 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index f505227b0250..addf245226f6 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -10,3 +10,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
new file mode 100644
index 000000000000..d36de5eb81f3
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+/dts-v1/;
+
+#include "sun50i-h6.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Pine H64";
+	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
-- 
2.15.1
