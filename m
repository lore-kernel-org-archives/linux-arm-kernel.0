From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:09 +0100
Subject: [PATCH 12/41] ARM: ux500: Supply the UART clocks lookup to the DBX500
 DT
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 0742e55..13ea13e 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -663,6 +663,9 @@
 			       <&dma 13 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 1 0>, <&prcc_pclk 1 0>;
+			clock-names = "uart", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -675,6 +678,9 @@
 			       <&dma 12 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 1 1>, <&prcc_pclk 1 1>;
+			clock-names = "uart", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -687,6 +693,9 @@
 			       <&dma 11 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 3 6>, <&prcc_pclk 3 6>;
+			clock-names = "uart", "apb_pclk";
+
 			status = "disabled";
 		};
 
-- 
1.8.1.2
