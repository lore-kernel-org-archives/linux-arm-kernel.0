From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 8 Nov 2017 14:53:23 +0200
Subject: [PATCH] ARM: dts: dra7: Add missing hdmi audio DMA channel information
Message-ID: <20171108125323.7070-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audio DMA request for hdmi is crossbar 76 and we use sDMA
to handle the data transfer.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index ac9216293b7c..a61802b0c4b9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1907,6 +1907,8 @@
 				ti,hwmods = "dss_hdmi";
 				clocks = <&dss_48mhz_clk>, <&dss_hdmi_clk>;
 				clock-names = "fck", "sys_clk";
+				dmas = <&sdma_xbar 76>;
+				dma-names = "audio_tx";
 			};
 		};
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
