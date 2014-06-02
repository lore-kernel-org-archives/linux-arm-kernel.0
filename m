From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  2 Jun 2014 15:42:11 +0200
Subject: [PATCH v2 7/7] ARM: shmobile: r8a7791 dtsi: Enable DMA for QSPI
In-Reply-To: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1401716531-29794-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DMA property to the QSPI node

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - QSPI needs to use 8-bit accesses for DMA, not 32-bit,
  - Reorder: TX first, RX second.

 arch/arm/boot/dts/r8a7791.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 37685ef32ea0..6c285ffc46cb 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -917,6 +917,9 @@
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
+		dmas = <&dma0 R8A7791_DMA_QSPI_TX CHCR_TX_8BIT>,
+		       <&dma0 R8A7791_DMA_QSPI_RX CHCR_RX_8BIT>;
+		dma-names = "tx", "rx";
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.9.1
