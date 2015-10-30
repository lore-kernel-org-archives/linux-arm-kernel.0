From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 30 Oct 2015 09:54:58 +0200
Subject: [PATCH v3 1/3] ARM: DTS: dra7: Fix McASP3 node regarding to clocks
In-Reply-To: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
References: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1446191700-11057-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

McASP node needs to list all mandatory clocks: gfclk and ahclkx

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index bc672fb91466..fe99231cbde5 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1459,8 +1459,8 @@
 			interrupt-names = "tx", "rx";
 			dmas = <&sdma_xbar 133>, <&sdma_xbar 132>;
 			dma-names = "tx", "rx";
-			clocks = <&mcasp3_ahclkx_mux>;
-			clock-names = "fck";
+			clocks = <&mcasp3_aux_gfclk_mux>, <&mcasp3_ahclkx_mux>;
+			clock-names = "fck", "ahclkx";
 			status = "disabled";
 		};
 
-- 
2.6.1
