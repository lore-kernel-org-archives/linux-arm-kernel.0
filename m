From: b44548@freescale.com (Chao Fu)
Date: Tue, 25 Feb 2014 14:54:17 +0800
Subject: [PATCH 2/3] arm:dts:vf-610:add vybrid DSPI DMA transfer support
In-Reply-To: <1393311258-14380-1-git-send-email-b44548@freescale.com>
References: <1393311258-14380-1-git-send-email-b44548@freescale.com>
Message-ID: <1393311258-14380-2-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

DSPI can transfer data in DMA mode or PIO mode.
The ajudgement of using DMA method(use-dma) will be read from dtb.
And add DMA channels info of DSPI.

Signed-off-by: Chao Fu      <b44548@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index e1e1e51..2fe53c1 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -148,6 +148,10 @@
 				clocks = <&clks VF610_CLK_DSPI0>;
 				clock-names = "dspi";
 				spi-num-chipselects = <5>;
+				use-dma;
+				dmas = <&edma0 0 12>,
+					<&edma0 0 13>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
-- 
1.8.4
