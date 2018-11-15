From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 15 Nov 2018 15:50:01 +0100
Subject: [PATCH 03/15] ARM: dts: sun8i-h3: Fix the system-control register
 range
In-Reply-To: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181115145013.3378-4-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike in previous generations, the system-control register range is not
limited to a size of 0x30 on the H3. In particular, the EMAC clock
configuration register (accessed through syscon) is at offset 0x30 in
that range.

Extend the register size to its full range (0x1000) as a result.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 35d025af7deb..7157d954fb8c 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -136,7 +136,7 @@
 	soc {
 		system-control at 1c00000 {
 			compatible = "allwinner,sun8i-h3-system-control";
-			reg = <0x01c00000 0x30>;
+			reg = <0x01c00000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
2.19.1
