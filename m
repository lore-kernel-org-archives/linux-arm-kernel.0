From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Aug 2014 09:23:58 +0900
Subject: [PATCH 07/12] ARM: shmobile: r8a7791 dtsi: Enable DMA for QSPI
In-Reply-To: <cover.1408492753.git.horms+renesas@verge.net.au>
References: <cover.1408492753.git.horms+renesas@verge.net.au>
Message-ID: <591f2fa4eb0aae09cd76d276bb59e25824a7d408.1408492753.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a DMA property to the QSPI node

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 146ed64..ab55efd 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1012,6 +1012,8 @@
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
+		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
+		dma-names = "tx", "rx";
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.0.1
