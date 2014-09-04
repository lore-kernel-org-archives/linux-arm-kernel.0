From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:25 +0900
Subject: [PATCH 2/5] ARM: shmobile: r8a73a4 dtsi: Add SoC-specific thermal
 compatible property
In-Reply-To: <cover.1409792871.git.horms+renesas@verge.net.au>
References: <cover.1409792871.git.horms+renesas@verge.net.au>
Message-ID: <a2cfaa7458e714aa00be98c630afaa1a4766e2ad.1409792871.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The thermal node used the generic compatible property only.
Add the SoC-specific one, to make it future proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index d8ec505..fba39a2 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -165,7 +165,7 @@
 	};
 
 	thermal at e61f0000 {
-		compatible = "renesas,rcar-thermal";
+		compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
 			 <0 0xe61f0200 0 0x38>, <0 0xe61f0300 0 0x38>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.0.1
