From: joelf@ti.com (Joel Fernandes)
Date: Fri, 25 Apr 2014 18:02:48 -0500
Subject: [PATCH 10/10] ARM: dts: OMAP4: Add clock nodes for AES/DES nodes
In-Reply-To: <1398466968-29506-1-git-send-email-joelf@ti.com>
References: <1398466968-29506-1-git-send-email-joelf@ti.com>
Message-ID: <1398466968-29506-11-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AES/DES nodes have clock nodes in the clock tree, use them. Internal trees were
using hwmod, but now that clock nodes are there, we can use them instead and
upstream it.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 27fcac8..f19ffa8 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -806,6 +806,8 @@
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&sdma 111>, <&sdma 110>;
 			dma-names = "tx", "rx";
+			clocks = <&aes1_fck>;
+			clock-names = "fck";
 		};
 
 		des: des at 480a5000 {
@@ -815,6 +817,8 @@
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&sdma 117>, <&sdma 116>;
 			dma-names = "tx", "rx";
+			clocks = <&des_fck>;
+			clock-names = "fck";
 		};
 
 		abb_mpu: regulator-abb-mpu {
-- 
1.7.9.5
