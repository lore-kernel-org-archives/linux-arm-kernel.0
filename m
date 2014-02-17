From: yao.yuan@freescale.com (Yuan Yao)
Date: Mon, 17 Feb 2014 13:28:06 +0800
Subject: [PATCH v6 1/3] ARM: dts: vf610: lpuart: Add eDMA support
In-Reply-To: <1392614888-10261-1-git-send-email-yao.yuan@freescale.com>
References: <1392614888-10261-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1392614888-10261-2-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add lpuart dts node properties for eDMA support, them depend on the eDMA driver.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/vf610.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 365e0fa..8f523b0 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -94,6 +94,9 @@
 				interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART0>;
 				clock-names = "ipg";
+				dmas = <&edma0 0 2>,
+					<&edma0 0 3>;
+				dma-names = "rx","tx";
 				status = "disabled";
 			};
 
@@ -103,6 +106,9 @@
 				interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART1>;
 				clock-names = "ipg";
+				dmas = <&edma0 0 4>,
+					<&edma0 0 5>;
+				dma-names = "rx","tx";
 				status = "disabled";
 			};
 
@@ -112,6 +118,9 @@
 				interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART2>;
 				clock-names = "ipg";
+				dmas = <&edma0 0 6>,
+					<&edma0 0 7>;
+				dma-names = "rx","tx";
 				status = "disabled";
 			};
 
@@ -121,6 +130,9 @@
 				interrupts = <0 64 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART3>;
 				clock-names = "ipg";
+				dmas = <&edma0 0 8>,
+					<&edma0 0 9>;
+				dma-names = "rx","tx";
 				status = "disabled";
 			};
 
-- 
1.8.4
