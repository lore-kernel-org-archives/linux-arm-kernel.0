From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:30:11 +0100
Subject: [PATCH 33/37] ARM: dts: iwg22d-sodimm: Sound DMA support on DTS
In-Reply-To: <cover.1513938145.git.horms+renesas@verge.net.au>
References: <cover.1513938145.git.horms+renesas@verge.net.au>
Message-ID: <b3f36c455ccce0acd33b6d055dead4396a1b1b43.1513938145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

DMA transfer to/from SSI

     DMA
[MEM] -> [SSI]

     DMA
[MEM] <- [SSI]

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index b6521da8b766..a9ba46d804bc 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -207,11 +207,11 @@
 };
 
 &ssi3 {
-	pio-transfer;
+	no-busif;
 };
 
 &ssi4 {
-	pio-transfer;
+	no-busif;
 	shared-pin;
 };
 
-- 
2.11.0
