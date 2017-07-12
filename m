From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 12 Jul 2017 11:03:24 +0100
Subject: [PATCH 2/3] ARM: dts: r8a7743: Add MMCIF0 support
In-Reply-To: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
References: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1499853805-5915-3-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the MMCIF0 device to the r8a7743 device tree.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 0d02191..f62e858 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -641,6 +641,22 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		mmcif0: mmc at ee200000 {
+			compatible = "renesas,mmcif-r8a7743",
+				     "renesas,sh-mmcif";
+			reg = <0 0xee200000 0 0x80>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 315>;
+			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+			       <&dmac1 0xd1>, <&dmac1 0xd2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 315>;
+			reg-io-width = <4>;
+			max-frequency = <97500000>;
+			status = "disabled";
+		};
 	};
 
 	/* External root clock */
-- 
1.9.1
