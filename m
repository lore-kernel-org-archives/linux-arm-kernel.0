From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:16 +0100
Subject: [PATCH 07/25] ARM: dts: sh73a0: Use SoC-specific compat string for
 mmcif
In-Reply-To: <cover.1483700969.git.horms+renesas@verge.net.au>
References: <cover.1483700969.git.horms+renesas@verge.net.au>
Message-ID: <5ff43b37ce967ffbcc4a93c76a9b270e441a72e6.1483700969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the SoC-specific compat string for mmcif in DT for the sh73a0 SoC.
This is in keeping with the use of compat strings for mmcif for other
Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index e1267590b575..6b01ab354e88 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -263,7 +263,7 @@
 	};
 
 	mmcif: mmc at e6bd0000 {
-		compatible = "renesas,sh-mmcif";
+		compatible = "renesas,mmcif-sh73a0", "renesas,sh-mmcif";
 		reg = <0xe6bd0000 0x100>;
 		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH
 			      GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.7.0.rc3.207.g0ac5344
