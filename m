From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:16:59 +0100
Subject: [PATCH 11/33] ARM: ux500: Supply the SDI (MMC) clocks lookup to the
 DBX500 DT
In-Reply-To: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370521041-32318-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 8cfe5f1..6b9c3a4 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -703,6 +703,9 @@
 			       <&dma 29 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
+			clock-names = "sdi0", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -715,6 +718,9 @@
 			       <&dma 32 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 2 4>, <&prcc_pclk 2 6>;
+			clock-names = "sdi1", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -727,6 +733,9 @@
 			       <&dma 28 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 3 4>, <&prcc_pclk 3 4>;
+			clock-names = "sdi2", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -734,6 +743,10 @@
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80119000 0x1000>;
 			interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&prcc_kclk 2 5>, <&prcc_pclk 2 7>;
+			clock-names = "sdi3", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -746,6 +759,9 @@
 			       <&dma 42 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 2 2>, <&prcc_pclk 2 4>;
+			clock-names = "sdi4", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -753,6 +769,10 @@
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80008000 0x1000>;
 			interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&prcc_kclk 3 7>, <&prcc_pclk 3 7>;
+			clock-names = "sdi5", "apb_pclk";
+
 			status = "disabled";
 		};
 
-- 
1.7.10.4
