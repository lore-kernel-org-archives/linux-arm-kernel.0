From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 17 Aug 2017 13:20:22 +0200
Subject: [RFC 1/4] dt-bindings: clock: Add Realtek RTD1295
In-Reply-To: <20170817112026.24062-1-afaerber@suse.de>
References: <20170817112026.24062-1-afaerber@suse.de>
Message-ID: <20170817112026.24062-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Naming inspired from Zidoo X9S Device Tree and clk_summary.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 .../devicetree/bindings/clock/realtek,rtd129x.txt  | 20 +++++
 include/dt-bindings/clock/realtek,rtd1295.h        | 99 ++++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/realtek,rtd129x.txt
 create mode 100644 include/dt-bindings/clock/realtek,rtd1295.h

diff --git a/Documentation/devicetree/bindings/clock/realtek,rtd129x.txt b/Documentation/devicetree/bindings/clock/realtek,rtd129x.txt
new file mode 100644
index 000000000000..b55da39faf58
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/realtek,rtd129x.txt
@@ -0,0 +1,20 @@
+Realtek RTD129x clock controllers
+=================================
+
+Requires properties:
+- compatible   :  Should be one of the following:
+                  - "realtek,rtd1295-clk"
+                  - "realtek,rtd1295-iso-clk"
+- reg          :  Specifies physical base address and size
+- clocks       :  Specifies the oscillator node
+- #clock-cells :  Shall be 1
+
+
+Example:
+
+	clock-controller at 98000000 {
+		compatible = "realtek,rtd1295-clk";
+		reg = <0x98000000 0x1000>;
+		clocks = <&osc27M>;
+		#clock-cells = <1>;
+	};
diff --git a/include/dt-bindings/clock/realtek,rtd1295.h b/include/dt-bindings/clock/realtek,rtd1295.h
new file mode 100644
index 000000000000..278148bff2ac
--- /dev/null
+++ b/include/dt-bindings/clock/realtek,rtd1295.h
@@ -0,0 +1,99 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+#ifndef DT_BINDINGS_CLOCK_RTD1295_H
+#define DT_BINDINGS_CLOCK_RTD1295_H
+
+#define RTD1295_CLK_PLL_SCPU		0
+#define RTD1295_CLK_PLL_BUS		1
+#define RTD1295_CLK_PLL_BUS_DIV2	2
+#define RTD1295_CLK_SYS			3
+#define RTD1295_CLK_PLL_BUS_H		4
+#define RTD1295_CLK_SYSH		5
+#define RTD1295_CLK_PLL_DDSA		6
+#define RTD1295_CLK_PLL_DDSB		7
+#define RTD1295_CLK_PLL_VODMA		8
+#define RTD1295_CLK_PLL_VE1		9
+#define RTD1295_CLK_PLL_VE2		10
+#define RTD1295_CLK_PLL_GPU		14
+#define RTD1295_CLK_PLL_ACPU		15
+
+#define RTD1295_CLK_EN_BASE		16
+#define RTD1295_CLK_EN_MISC		(RTD1295_CLK_EN_BASE + 0)
+#define RTD1295_CLK_EN_PCIE0		(RTD1295_CLK_EN_BASE + 1)
+#define RTD1295_CLK_EN_SATA_0		(RTD1295_CLK_EN_BASE + 2)
+#define RTD1295_CLK_EN_GSPI		(RTD1295_CLK_EN_BASE + 3)
+#define RTD1295_CLK_EN_USB		(RTD1295_CLK_EN_BASE + 4)
+#define RTD1295_CLK_EN_PCR		(RTD1295_CLK_EN_BASE + 5)
+#define RTD1295_CLK_EN_ISO_MISC		(RTD1295_CLK_EN_BASE + 6)
+#define RTD1295_CLK_EN_SATA_ALIVE_0	(RTD1295_CLK_EN_BASE + 7)
+#define RTD1295_CLK_EN_HDMI		(RTD1295_CLK_EN_BASE + 8)
+#define RTD1295_CLK_EN_ETN		(RTD1295_CLK_EN_BASE + 9)
+#define RTD1295_CLK_EN_AIO		(RTD1295_CLK_EN_BASE + 10)
+#define RTD1295_CLK_EN_GPU		(RTD1295_CLK_EN_BASE + 11)
+#define RTD1295_CLK_EN_VE1		(RTD1295_CLK_EN_BASE + 12)
+#define RTD1295_CLK_EN_VE2		(RTD1295_CLK_EN_BASE + 13)
+#define RTD1295_CLK_EN_TVE		(RTD1295_CLK_EN_BASE + 14)
+#define RTD1295_CLK_EN_VO		(RTD1295_CLK_EN_BASE + 15)
+#define RTD1295_CLK_EN_LVDS		(RTD1295_CLK_EN_BASE + 16)
+#define RTD1295_CLK_EN_SE		(RTD1295_CLK_EN_BASE + 17)
+#define RTD1295_CLK_EN_DCU		(RTD1295_CLK_EN_BASE + 18)
+#define RTD1295_CLK_EN_CP		(RTD1295_CLK_EN_BASE + 19)
+#define RTD1295_CLK_EN_MD		(RTD1295_CLK_EN_BASE + 20)
+#define RTD1295_CLK_EN_TP		(RTD1295_CLK_EN_BASE + 21)
+#define RTD1295_CLK_EN_RSA		(RTD1295_CLK_EN_BASE + 22)
+#define RTD1295_CLK_EN_NF		(RTD1295_CLK_EN_BASE + 23)
+#define RTD1295_CLK_EN_EMMC		(RTD1295_CLK_EN_BASE + 24)
+#define RTD1295_CLK_EN_CR		(RTD1295_CLK_EN_BASE + 25)
+#define RTD1295_CLK_EN_SDIO_IP		(RTD1295_CLK_EN_BASE + 26)
+#define RTD1295_CLK_EN_MIPI		(RTD1295_CLK_EN_BASE + 27)
+#define RTD1295_CLK_EN_EMMC_IP		(RTD1295_CLK_EN_BASE + 28)
+#define RTD1295_CLK_EN_VE3		(RTD1295_CLK_EN_BASE + 29)
+#define RTD1295_CLK_EN_SDIO		(RTD1295_CLK_EN_BASE + 30)
+#define RTD1295_CLK_EN_SD_IP		(RTD1295_CLK_EN_BASE + 31)
+
+#define RTD1295_CLK_EN_BASE2		(RTD1295_CLK_EN_BASE + 32)
+#define RTD1295_CLK_EN_NAT		(RTD1295_CLK_EN_BASE2 + 0)
+#define RTD1295_CLK_EN_MISC_I2C_5	(RTD1295_CLK_EN_BASE2 + 1)
+#define RTD1295_CLK_EN_SCPU		(RTD1295_CLK_EN_BASE2 + 2)
+#define RTD1295_CLK_EN_JPEG		(RTD1295_CLK_EN_BASE2 + 3)
+#define RTD1295_CLK_EN_APU		(RTD1295_CLK_EN_BASE2 + 4)
+#define RTD1295_CLK_EN_PCIE1		(RTD1295_CLK_EN_BASE2 + 5)
+#define RTD1295_CLK_EN_MISC_SC		(RTD1295_CLK_EN_BASE2 + 6)
+#define RTD1295_CLK_EN_CBUS_TX		(RTD1295_CLK_EN_BASE2 + 7)
+#define RTD1295_CLK_EN_MISC_RTC		(RTD1295_CLK_EN_BASE2 + 10)
+#define RTD1295_CLK_EN_MISC_I2C_4	(RTD1295_CLK_EN_BASE2 + 13)
+#define RTD1295_CLK_EN_MISC_I2C_3	(RTD1295_CLK_EN_BASE2 + 14)
+#define RTD1295_CLK_EN_MISC_I2C_2	(RTD1295_CLK_EN_BASE2 + 15)
+#define RTD1295_CLK_EN_MISC_I2C_1	(RTD1295_CLK_EN_BASE2 + 16)
+#define RTD1295_CLK_EN_AIO_AU_CODEC	(RTD1295_CLK_EN_BASE2 + 17)
+#define RTD1295_CLK_EN_AIO_MOD		(RTD1295_CLK_EN_BASE2 + 18)
+#define RTD1295_CLK_EN_AIO_DA		(RTD1295_CLK_EN_BASE2 + 19)
+#define RTD1295_CLK_EN_AIO_HDMI		(RTD1295_CLK_EN_BASE2 + 20)
+#define RTD1295_CLK_EN_AIO_SPDIF	(RTD1295_CLK_EN_BASE2 + 21)
+#define RTD1295_CLK_EN_AIO_I2S		(RTD1295_CLK_EN_BASE2 + 22)
+#define RTD1295_CLK_EN_AIO_MCLK		(RTD1295_CLK_EN_BASE2 + 23)
+#define RTD1295_CLK_EN_HDMIRX		(RTD1295_CLK_EN_BASE2 + 24)
+#define RTD1295_CLK_EN_SATA_1		(RTD1295_CLK_EN_BASE2 + 25)
+#define RTD1295_CLK_EN_SATA_ALIVE_1	(RTD1295_CLK_EN_BASE2 + 26)
+#define RTD1295_CLK_EN_UR2		(RTD1295_CLK_EN_BASE2 + 27)
+#define RTD1295_CLK_EN_UR1		(RTD1295_CLK_EN_BASE2 + 28)
+#define RTD1295_CLK_EN_FAN		(RTD1295_CLK_EN_BASE2 + 29)
+#define RTD1295_CLK_EN_DCPHY_0		(RTD1295_CLK_EN_BASE2 + 30)
+#define RTD1295_CLK_EN_DCPHY_1		(RTD1295_CLK_EN_BASE2 + 31)
+
+#define RTD1295_ISO_CLK_EN_MISC_CEC0	2
+#define RTD1295_ISO_CLK_EN_CBUSRX_SYS	3
+#define RTD1295_ISO_CLK_EN_CBUSTX_SYS	4
+#define RTD1295_ISO_CLK_EN_CBUS_SYS	5
+#define RTD1295_ISO_CLK_EN_CBUS_OSC	6
+#define RTD1295_ISO_CLK_EN_MISC_IR	7
+#define RTD1295_ISO_CLK_EN_MISC_UR0	8
+#define RTD1295_ISO_CLK_EN_I2C_0	9
+#define RTD1295_ISO_CLK_EN_I2C_1	10
+#define RTD1295_ISO_CLK_EN_ETN_250M	11
+#define RTD1295_ISO_CLK_EN_ETN_SYS	12
+
+#endif
-- 
2.12.3
