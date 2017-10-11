From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Wed, 11 Oct 2017 09:35:29 +0300
Subject: [PATCH v2 2/5] ARM: dts: at91: sama5d2: added dma property for ADC
 device
In-Reply-To: <1507703732-29175-1-git-send-email-eugen.hristev@microchip.com>
References: <1507703732-29175-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1507703732-29175-3-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added DMA property for ADC device

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index cc06da3..8b4c60c 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1368,6 +1368,8 @@
 				atmel,min-sample-rate-hz = <200000>;
 				atmel,max-sample-rate-hz = <20000000>;
 				atmel,startup-time-ms = <4>;
+				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
-- 
2.7.4
