From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:30:13 +0100
Subject: [PATCH 35/37] ARM: dts: iwg22d-sodimm: Sound DMA support via SRC on
 DTS
In-Reply-To: <cover.1513938145.git.horms+renesas@verge.net.au>
References: <cover.1513938145.git.horms+renesas@verge.net.au>
Message-ID: <5ce5faa6fcf8b643ab91f48b972fd850f33d8f57.1513938145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

DMA transfer to/from SRC

     DMA      DMApp
[MEM] -> [SRC] -> [SSIU] -> [SSI]

     DMA      DMApp
[MEM] <- [SRC] <- [SSIU] <- [SSI]

Current sound driver is supporting SSI/SRC random connection.
So, this patch is trying
SSI3 -> SRC3
SSI4 <- SRC4

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index 0f880c1e7afa..2cac57c7c44d 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -183,8 +183,8 @@
 
 	rcar_sound,dai {
 		dai0 {
-			playback = <&ssi3>;
-			capture = <&ssi4>;
+			playback = <&ssi3 &src3>;
+			capture = <&ssi4 &src4>;
 		};
 	};
 };
-- 
2.11.0
