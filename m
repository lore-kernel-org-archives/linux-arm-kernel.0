From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:05 +0100
Subject: [PATCH 10/61] ARM: dts: iwg22d: Use /dev/ttySC3 as debug console
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <4c1d14ce4a03af24c2bac21c4a19f17d20b4a763.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

The BSP release from iWave uses /dev/ttySC3 as debug console, this patch
renames the alias accordingly for compatibility.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index 52153ec3638c..edadeee8f1ec 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -16,13 +16,13 @@
 	compatible = "iwave,g22d", "iwave,g22m", "renesas,r8a7745";
 
 	aliases {
-		serial0 = &scif4;
+		serial3 = &scif4;
 		ethernet0 = &avb;
 	};
 
 	chosen {
 		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = "serial0:115200n8";
+		stdout-path = "serial3:115200n8";
 	};
 
 	vccq_sdhi0: regulator-vccq-sdhi0 {
-- 
2.11.0
