From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 17 Aug 2017 18:31:42 +0100
Subject: [PATCH 1/2] ARM: dts: r8a7745: Add MMC interface support
In-Reply-To: <1502991103-2325-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1502991103-2325-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1502991103-2325-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MMC interface support for r8a7745 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index aff90df..e17289f 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -508,6 +508,22 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		mmcif0: mmc at ee200000 {
+			compatible = "renesas,mmcif-r8a7745",
+				     "renesas,sh-mmcif";
+			reg = <0 0xee200000 0 0x80>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 315>;
+			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+			       <&dmac1 0xd1>, <&dmac1 0xd2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
+			resets = <&cpg 315>;
+			reg-io-width = <4>;
+			max-frequency = <97500000>;
+			status = "disabled";
+		};
 	};
 
 	/* External root clock */
-- 
2.7.4
