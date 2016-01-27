From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 27 Jan 2016 15:11:58 -0600
Subject: [PATCH 10/13] dtb: amd: Add AMD XGBE device tree file
In-Reply-To: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1453929121-12171-11-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Add AMD XGBE device tree file, which is available in AMD Seattle RevB.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 MAINTAINERS                                     |   1 +
 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi | 117 ++++++++++++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 8179121..d525585 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -682,6 +682,7 @@ M:	Tom Lendacky <thomas.lendacky@amd.com>
 L:	netdev at vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/amd/xgbe/
+F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 
 AMS (Apple Motion Sensor) DRIVER
 M:	Michael Hanselmann <linux-kernel@hansmi.ch>
diff --git a/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
new file mode 100644
index 0000000..8e86319
--- /dev/null
+++ b/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
@@ -0,0 +1,117 @@
+/*
+ * DTS file for AMD Seattle XGBE (RevB)
+ *
+ * Copyright (C) 2015 Advanced Micro Devices, Inc.
+ */
+
+	xgmacclk0_dma_250mhz: clk250mhz_0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <250000000>;
+		clock-output-names = "xgmacclk0_dma_250mhz";
+	};
+
+	xgmacclk0_ptp_250mhz: clk250mhz_1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <250000000>;
+		clock-output-names = "xgmacclk0_ptp_250mhz";
+	};
+
+	xgmacclk1_dma_250mhz: clk250mhz_2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <250000000>;
+		clock-output-names = "xgmacclk1_dma_250mhz";
+	};
+
+	xgmacclk1_ptp_250mhz: clk250mhz_3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <250000000>;
+		clock-output-names = "xgmacclk1_ptp_250mhz";
+	};
+
+	xgmac0: xgmac at e0700000 {
+		compatible = "amd,xgbe-seattle-v1a";
+		reg = <0 0xe0700000 0 0x80000>,
+		      <0 0xe0780000 0 0x80000>,
+		      <0 0xe1240800 0 0x00400>, /* SERDES RX/TX0 */
+		      <0 0xe1250000 0 0x00060>, /* SERDES IR 1/2 */
+		      <0 0xe12500f8 0 0x00004>; /* SERDES IR 2/2 */
+		interrupts = <0 325 4>,
+			     <0 346 1>, <0 347 1>, <0 348 1>, <0 349 1>,
+			     <0 323 4>;
+		amd,per-channel-interrupt;
+		amd,speed-set = <0>;
+		amd,serdes-blwc = <1>, <1>, <0>;
+		amd,serdes-cdr-rate = <2>, <2>, <7>;
+		amd,serdes-pq-skew = <10>, <10>, <18>;
+		amd,serdes-tx-amp = <0>, <0>, <0>;
+		amd,serdes-dfe-tap-config = <3>, <3>, <3>;
+		amd,serdes-dfe-tap-enable = <0>, <0>, <7>;
+		mac-address = [ 02 A1 A2 A3 A4 A5 ];
+		clocks = <&xgmacclk0_dma_250mhz>, <&xgmacclk0_ptp_250mhz>;
+		clock-names = "dma_clk", "ptp_clk";
+		phy-mode = "xgmii";
+		#stream-id-cells = <16>;
+		dma-coherent;
+	};
+
+	xgmac1: xgmac at e0900000 {
+		compatible = "amd,xgbe-seattle-v1a";
+		reg = <0 0xe0900000 0 0x80000>,
+		      <0 0xe0980000 0 0x80000>,
+		      <0 0xe1240c00 0 0x00400>, /* SERDES RX/TX1 */
+		      <0 0xe1250080 0 0x00060>, /* SERDES IR 1/2 */
+		      <0 0xe12500fc 0 0x00004>; /* SERDES IR 2/2 */
+		interrupts = <0 324 4>,
+			     <0 341 1>, <0 342 1>, <0 343 1>, <0 344 1>,
+			     <0 322 4>;
+		amd,per-channel-interrupt;
+		amd,speed-set = <0>;
+		amd,serdes-blwc = <1>, <1>, <0>;
+		amd,serdes-cdr-rate = <2>, <2>, <7>;
+		amd,serdes-pq-skew = <10>, <10>, <18>;
+		amd,serdes-tx-amp = <0>, <0>, <0>;
+		amd,serdes-dfe-tap-config = <3>, <3>, <3>;
+		amd,serdes-dfe-tap-enable = <0>, <0>, <7>;
+		mac-address = [ 02 B1 B2 B3 B4 B5 ];
+		clocks = <&xgmacclk1_dma_250mhz>, <&xgmacclk1_ptp_250mhz>;
+		clock-names = "dma_clk", "ptp_clk";
+		phy-mode = "xgmii";
+		#stream-id-cells = <16>;
+		dma-coherent;
+	};
+
+	xgmac0_smmu: smmu at e0600000 {
+		 compatible = "arm,mmu-401";
+		 reg = <0 0xe0600000 0 0x10000>;
+		 #global-interrupts = <1>;
+		 interrupts = /* Uses combined intr for both
+			       * global and context
+			       */
+			      <0 336 4>,
+			      <0 336 4>;
+
+		 mmu-masters = <&xgmac0
+			  0  1  2  3  4  5  6  7
+			 16 17 18 19 20 21 22 23
+		 >;
+	 };
+
+	 xgmac1_smmu: smmu at e0800000 {
+		 compatible = "arm,mmu-401";
+		 reg = <0 0xe0800000 0 0x10000>;
+		 #global-interrupts = <1>;
+		 interrupts = /* Uses combined intr for both
+			       * global and context
+			       */
+			      <0 335 4>,
+			      <0 335 4>;
+
+		 mmu-masters = <&xgmac1
+			  0  1  2  3  4  5  6  7
+			 16 17 18 19 20 21 22 23
+		 >;
+	 };
-- 
2.5.0
