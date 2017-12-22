From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:30:12 +0100
Subject: [PATCH 34/37] ARM: dts: iwg22d-sodimm: Sound DMA support via BUSIF on
 DTS
In-Reply-To: <cover.1513938145.git.horms+renesas@verge.net.au>
References: <cover.1513938145.git.horms+renesas@verge.net.au>
Message-ID: <996d68a1f4fd6f95ab340d84871cbdcb34bc74f4.1513938145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

DMA transfer to/from SSIU

     DMA
[MEM] -> [SSIU] -> [SSI]

     DMA
[MEM] <- [SSIU] <- [SSI]

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index a9ba46d804bc..0f880c1e7afa 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -206,12 +206,7 @@
 	status = "okay";
 };
 
-&ssi3 {
-	no-busif;
-};
-
 &ssi4 {
-	no-busif;
 	shared-pin;
 };
 
-- 
2.11.0
