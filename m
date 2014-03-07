From: r.sricharan@ti.com (Sricharan R)
Date: Fri, 7 Mar 2014 17:46:16 +0530
Subject: [RFC PATCH 9/9] arm: dts: dra7: Change the total dma-req numbers to
 crossbar channels
In-Reply-To: <1394194576-23741-1-git-send-email-r.sricharan@ti.com>
References: <1394194576-23741-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1394194576-23741-10-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On DRA7 there is a crossbar router which maps the peripheral
dma request channels to the dma controller inputs. The
dma-controller can receive requests from any of the crossbar
channels. So register the total number crossbar channels instead
of the shared dma-request lines.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index baa781e..f5ae8c9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -167,7 +167,7 @@
 				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <2>;
 			#dma-channels = <32>;
-			#dma-requests = <127>;
+			#dma-requests = <203>;
 		};
 
 		dmacb: crossbar at 4a020000 {
-- 
1.7.9.5
