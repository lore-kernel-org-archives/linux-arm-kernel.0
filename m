From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 13:56:53 +0100
Subject: [PATCH 1/2] ARM: ux500: switch SSP/SPI clock name to "SSPCLK"
Message-ID: <1393246613-16197-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As noted in recent discussions the name of the core clock for
the PL022 derived SPI blocks is erroneously named in the
Ux500 device trees. The kernel doesn't currently use the name,
but may do so soon so let use rename all these clocks in
accordance with the name given in the PL022 TRM (ARM DDI 0194G).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index e0853ea02df2..e41eedca3ce3 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -705,7 +705,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&prcc_kclk 3 1>, <&prcc_pclk 3 1>;
-			clock-names = "ssp0clk", "apb_pclk";
+			clock-names = "SSPCLK", "apb_pclk";
 			dmas = <&dma 8 0 0x2>, /* Logical - DevToMem */
 			       <&dma 8 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -718,7 +718,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&prcc_kclk 3 2>, <&prcc_pclk 3 2>;
-			clock-names = "ssp1clk", "apb_pclk";
+			clock-names = "SSPCLK", "apb_pclk";
 			dmas = <&dma 9 0 0x2>, /* Logical - DevToMem */
 			       <&dma 9 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -732,7 +732,7 @@
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 2 8>, <&prcc_pclk 2 8>;
-			clock-names = "spi0clk", "apb_pclk";
+			clock-names = "SSPCLK", "apb_pclk";
 			dmas = <&dma 0 0 0x2>, /* Logical - DevToMem */
 			       <&dma 0 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -746,7 +746,7 @@
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 2 2>, <&prcc_pclk 2 2>;
-			clock-names = "spi1clk", "apb_pclk";
+			clock-names = "SSPCLK", "apb_pclk";
 			dmas = <&dma 35 0 0x2>, /* Logical - DevToMem */
 			       <&dma 35 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -760,7 +760,7 @@
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 2 1>, <&prcc_pclk 2 1>;
-			clock-names = "spi2clk", "apb_pclk";
+			clock-names = "SSPCLK", "apb_pclk";
 			dmas = <&dma 33 0 0x2>, /* Logical - DevToMem */
 			       <&dma 33 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -774,7 +774,7 @@
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 1 7>, <&prcc_pclk 1 7>;
-			clock-names = "spi3clk", "apb_pclk";
+			clock-names = "SSPCLK", "apb_pclk";
 			dmas = <&dma 40 0 0x2>, /* Logical - DevToMem */
 			       <&dma 40 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
-- 
1.8.5.3
