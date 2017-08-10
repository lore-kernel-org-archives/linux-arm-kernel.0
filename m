From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Thu, 10 Aug 2017 15:34:58 +0300
Subject: [PATCH 2/3] ARM: dts: at91: sama5d2: added dma property for ADC device
In-Reply-To: <1502368499-6739-1-git-send-email-eugen.hristev@microchip.com>
References: <1502368499-6739-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1502368499-6739-3-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added DMA property for ADC device

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 8067c71..2f1dc77 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1267,6 +1267,8 @@
 				atmel,min-sample-rate-hz = <200000>;
 				atmel,max-sample-rate-hz = <20000000>;
 				atmel,startup-time-ms = <4>;
+				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
-- 
2.7.4
