From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:10 +0100
Subject: [PATCH 13/41] ARM: ux500: Supply the SDI (MMC) clocks lookup to the
 DBX500 DT
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 13ea13e..75c0646 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -708,6 +708,9 @@
 			       <&dma 29 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
+			clock-names = "sdi", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -720,6 +723,9 @@
 			       <&dma 32 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 2 4>, <&prcc_pclk 2 6>;
+			clock-names = "sdi", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -732,6 +738,9 @@
 			       <&dma 28 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 3 4>, <&prcc_pclk 3 4>;
+			clock-names = "sdi", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -739,6 +748,10 @@
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80119000 0x1000>;
 			interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&prcc_kclk 2 5>, <&prcc_pclk 2 7>;
+			clock-names = "sdi", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -751,6 +764,9 @@
 			       <&dma 42 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 2 2>, <&prcc_pclk 2 4>;
+			clock-names = "sdi", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -758,6 +774,10 @@
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80008000 0x1000>;
 			interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&prcc_kclk 3 7>, <&prcc_pclk 3 7>;
+			clock-names = "sdi", "apb_pclk";
+
 			status = "disabled";
 		};
 
-- 
1.8.1.2
