From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Nov 2016 21:15:14 +0100
Subject: [PATCH renesas-next 3/3] ARM: dts: sh73a0: Use SoC-specific compat
 string for mmcif
In-Reply-To: <1480018514-31718-1-git-send-email-horms+renesas@verge.net.au>
References: <1480018514-31718-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1480018514-31718-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the SoC-specific compat string for mmcif in DT for the sh73a0 SoC.
This is in keeping with the use of compat strings for mmcif for other
Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
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
