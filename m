From: joelf@ti.com (Joel Fernandes)
Date: Fri, 25 Apr 2014 18:02:46 -0500
Subject: [PATCH 08/10] ARM: dts: DRA7: Add DT node for AES IP
In-Reply-To: <1398466968-29506-1-git-send-email-joelf@ti.com>
References: <1398466968-29506-1-git-send-email-joelf@ti.com>
Message-ID: <1398466968-29506-9-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA7 SoC has same AES IP as on OMAP4. Add DT entries for the same.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 0533b89..c45f7e9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -790,6 +790,17 @@
 			status = "disabled";
 		};
 
+		aes: aes at 4b500000 {
+			compatible = "ti,omap4-aes";
+			ti,hwmods = "aes";
+			reg = <0x4b500000 0xa0>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&sdma 111>, <&sdma 110>;
+			dma-names = "tx", "rx";
+			clocks = <&l3_iclk_div>;
+			clock-names = "fck";
+		};
+
 		des: des at 480a5000 {
 			compatible = "ti,omap4-des";
 			ti,hwmods = "des";
-- 
1.7.9.5
