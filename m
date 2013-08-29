From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 29 Aug 2013 16:16:19 +0300
Subject: [PATCHv6 27/45] ARM: dts: AM35xx clock data
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Message-ID: <1377782197-10611-28-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch creates a unique node for each AM35xx specific clock in the
AM35xx power, reset and clock manager (PRCM). Most of the AM35xx clock
data is shared with OMAP3xxx, this patch only creates the delta.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am35xx-clocks.dtsi |  101 ++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 arch/arm/boot/dts/am35xx-clocks.dtsi

diff --git a/arch/arm/boot/dts/am35xx-clocks.dtsi b/arch/arm/boot/dts/am35xx-clocks.dtsi
new file mode 100644
index 0000000..7749413
--- /dev/null
+++ b/arch/arm/boot/dts/am35xx-clocks.dtsi
@@ -0,0 +1,101 @@
+/*
+ * Device Tree Source for AM35xx clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+ipss_ick: ipss_ick at 48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,am35xx-interface-clock";
+	clocks = <&core_l3_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,enable-bit = <4>;
+};
+
+rmii_ck: rmii_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <50000000>;
+};
+
+pclk_ck: pclk_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <27000000>;
+};
+
+emac_ick: emac_ick at 4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,am35xx-gate-clock";
+	clocks = <&ipss_ick>;
+	reg = <0x4800259c 0x4>;
+	ti,enable-bit = <1>;
+};
+
+emac_fck: emac_fck at 4800259c {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&rmii_ck>;
+	reg = <0x4800259c 0x4>;
+	bit-shift = <9>;
+};
+
+vpfe_ick: vpfe_ick at 4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,am35xx-gate-clock";
+	clocks = <&ipss_ick>;
+	reg = <0x4800259c 0x4>;
+	ti,enable-bit = <2>;
+};
+
+vpfe_fck: vpfe_fck at 4800259c {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&pclk_ck>;
+	reg = <0x4800259c 0x4>;
+	bit-shift = <10>;
+};
+
+hsotgusb_ick: hsotgusb_ick at 4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,am35xx-gate-clock";
+	clocks = <&ipss_ick>;
+	reg = <0x4800259c 0x4>;
+	ti,enable-bit = <0>;
+};
+
+hsotgusb_fck_am35xx: hsotgusb_fck_am35xx at 4800259c {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x4800259c 0x4>;
+	bit-shift = <8>;
+};
+
+hecc_ck: hecc_ck at 4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,am35xx-gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x4800259c 0x4>;
+	ti,enable-bit = <3>;
+};
+
+uart4_ick_am35xx: uart4_ick_am35xx at 48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,enable-bit = <23>;
+};
+
+uart4_fck_am35xx: uart4_fck_am35xx at 48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,enable-bit = <23>;
+};
-- 
1.7.9.5
