From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:39 +0900
Subject: [PATCH 08/30] ARM: shmobile: dts: koelsch: Fix flash partition label
 and size
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <5f950e62b476c62fd8a6549f3889e08e478252f3.1419812185.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the size and names of flash partitions to match the
expectations of the loader which are as follows:

"loader"---0x0000_0000-0x0008_0000 [loader program (readonly)]
"user"  ---0x0008_0000-0x0060_0000 [U-Boot + bootargs + dt + uImage (readonly)]
"flash" ---0x0060_0000-0x0400_0000 [filesystem and free (read/write)]

["user"'s assumed breakdown]
U-boot       (0x0008_0000-0x000c_0000) 256KiB
bootargs     (0x000c_0000-0x0010_0000) 256KiB
Device tree  (0x0010_0000-0x0014_0000) 256KiB
zImage       (0x0014_0000-0x0060_0000) 4.75MiB

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 990af16..1e5f8d2 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -452,13 +452,13 @@
 			read-only;
 		};
 		partition at 80000 {
-			label = "bootenv";
-			reg = <0x00080000 0x00080000>;
+			label = "user";
+			reg = <0x00080000 0x00580000>;
 			read-only;
 		};
-		partition at 100000 {
-			label = "data";
-			reg = <0x00100000 0x03f00000>;
+		partition at 600000 {
+			label = "flash";
+			reg = <0x00600000 0x03a00000>;
 		};
 	};
 };
-- 
2.1.3
