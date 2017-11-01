From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 1 Nov 2017 11:03:40 +0200
Subject: [PATCH] ARM: dts: am437x-cm-t43: Correct the dmas property of spi0
Message-ID: <20171101090340.15708-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA binding for eDMA needs 2 parameters, not 1.
The second, missing parameter is the tptc to be used for the channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am437x-cm-t43.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 9e92d480576b..3b9a94c274a7 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -301,8 +301,8 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;
-	dmas = <&edma 16
-		&edma 17>;
+	dmas = <&edma 16 0
+		&edma 17 0>;
 	dma-names = "tx0", "rx0";
 
 	flash: w25q64cvzpig at 0 {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
