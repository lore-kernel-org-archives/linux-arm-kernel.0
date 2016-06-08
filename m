From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:48 +0900
Subject: [PATCH 18/30] ARM: dts: sh73a0: Fix W=1 dtc warnings
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <1178814b0fc3649a9c586554e8f6d4f161a97c1f.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Warning (unit_address_vs_reg): Node /cache-controller has a reg or ranges property, but no unit name

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index c4f434cdec60..032fe2f14b16 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -55,7 +55,7 @@
 		      <0xf0000100 0x100>;
 	};
 
-	L2: cache-controller {
+	L2: cache-controller at f0100000 {
 		compatible = "arm,pl310-cache";
 		reg = <0xf0100000 0x1000>;
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4
