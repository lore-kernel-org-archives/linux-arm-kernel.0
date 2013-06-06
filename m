From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:16:58 +0100
Subject: [PATCH 10/33] ARM: ux500: Supply the UART clocks lookup to the DBX500
 DT
In-Reply-To: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370521041-32318-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index e49c679..8cfe5f1 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -658,6 +658,9 @@
 			       <&dma 13 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 1 0>, <&prcc_pclk 1 0>;
+			clock-names = "uart0", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -670,6 +673,9 @@
 			       <&dma 12 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 1 1>, <&prcc_pclk 1 1>;
+			clock-names = "uart1", "apb_pclk";
+
 			status = "disabled";
 		};
 
@@ -682,6 +688,9 @@
 			       <&dma 11 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
 
+			clocks = <&prcc_kclk 3 6>, <&prcc_pclk 3 6>;
+			clock-names = "uart2", "apb_pclk";
+
 			status = "disabled";
 		};
 
-- 
1.7.10.4
