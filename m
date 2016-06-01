From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 1 Jun 2016 12:06:42 +0300
Subject: [PATCH 24/28] ARM: dts: DRA7: Add DT nodes for AES IP
In-Reply-To: <1464772006-11254-1-git-send-email-t-kristo@ti.com>
References: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
 <1464772006-11254-1-git-send-email-t-kristo@ti.com>
Message-ID: <1464772006-11254-5-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joel Fernandes <joelf@ti.com>

DRA7 SoC has the same AES IP as OMAP4. Add DT entries for both AES cores.

Signed-off-by: Joel Fernandes <joelf@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
[t-kristo at ti.com: squashed in the change to use EDMA, squashed in
                  support for two AES cores]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 959f99b..da31a72 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1744,6 +1744,28 @@
 			};
 		};
 
+		aes1: aes at 4b500000 {
+			compatible = "ti,omap4-aes";
+			ti,hwmods = "aes1";
+			reg = <0x4b500000 0xa0>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&edma_xbar 111 0>, <&edma_xbar 110 0>;
+			dma-names = "tx", "rx";
+			clocks = <&l3_iclk_div>;
+			clock-names = "fck";
+		};
+
+		aes2: aes at 4b700000 {
+			compatible = "ti,omap4-aes";
+			ti,hwmods = "aes2";
+			reg = <0x4b700000 0xa0>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&edma_xbar 114 0>, <&edma_xbar 113 0>;
+			dma-names = "tx", "rx";
+			clocks = <&l3_iclk_div>;
+			clock-names = "fck";
+		};
+
 		des: des at 480a5000 {
 			compatible = "ti,omap4-des";
 			ti,hwmods = "des";
-- 
1.9.1
