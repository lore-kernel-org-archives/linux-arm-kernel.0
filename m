From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 19 Nov 2018 22:39:37 +0530
Subject: [PATCH 14/16] arm: dts: rda8810pl: Add interrupt support for UART
In-Reply-To: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181119170939.19153-15-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add interrupt support for UART in RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index 470a18585deb..07110c5784c9 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -87,18 +87,21 @@
 			uart0: serial at 0 {
 				compatible = "rda,8810pl-uart";
 				reg = <0x0 0x1000>;
+				interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			uart1: serial at 10000 {
 				compatible = "rda,8810pl-uart";
 				reg = <0x10000 0x1000>;
+				interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			uart2: serial at 90000 {
 				compatible = "rda,8810pl-uart";
 				reg = <0x90000 0x1000>;
+				interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 		};
-- 
2.17.1
