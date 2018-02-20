From: niklas.cassel@axis.com (Niklas Cassel)
Date: Tue, 20 Feb 2018 18:00:49 +0100
Subject: [PATCH 8/8] ARM: dts: artpec: add node for hardware crypto accelerator
In-Reply-To: <20180220170049.22809-1-niklas.cassel@axis.com>
References: <20180220170049.22809-1-niklas.cassel@axis.com>
Message-ID: <20180220170049.22809-9-niklas.cassel@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for the hardware crypto acceleration used in the artpec6 SoC.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/boot/dts/artpec6.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 8d02d210574a..c0bbdbc8c7ba 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -234,6 +234,12 @@
 		ranges;
 		dma-ranges;
 
+		crypto at f4264000 {
+			compatible = "axis,artpec6-crypto";
+			reg = <0xf4264000 0x4000>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		dma0: dma at f8019000 {
 			compatible = "renesas,nbpfaxi64dmac8b16";
 			reg = <0xf8019000 0x400>;
-- 
2.14.2
