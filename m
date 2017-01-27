From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Jan 2017 11:06:22 +0100
Subject: [PATCH 1/2] arm64: dts: r8a7796: Enable I2C DVFS DMA
In-Reply-To: <1485511583-21614-1-git-send-email-horms+renesas@verge.net.au>
References: <1485511583-21614-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1485511583-21614-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index c95ad177b097..c8592d05620b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -280,6 +280,9 @@
 			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 926>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			dmas = <&dmac1 0x11>, <&dmac1 0x10>,
+			       <&dmac2 0x11>, <&dmac2 0x10>;
+			dma-names = "tx", "rx", "tx", "rx";
 			status = "disabled";
 		};
 
-- 
2.7.0.rc3.207.g0ac5344
