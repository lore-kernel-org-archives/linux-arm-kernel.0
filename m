From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:02 +0900
Subject: [PATCH 10/13] ARM: shmobile: ape6evm dts: Drop console= bootargs
 parameter
In-Reply-To: <cover.1425517246.git.horms+renesas@verge.net.au>
References: <cover.1425517246.git.horms+renesas@verge.net.au>
Message-ID: <d1e21e3f57513c5ac09d722590f5ad6eee7ae1df.1425517246.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Since ("ARM: shmobile: r8a73a4: ape6evm: Remove legacy platform"),
ape6evm is restricted to booting from DT, so chosen/stdout-path is
always used, and we can drop the "console=" parameter from
chosen/bootargs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 44c4cac..f9e8151 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -22,7 +22,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
+		bootargs = "ignore_loglevel root=/dev/nfs ip=dhcp rw";
 		stdout-path = &scifa0;
 	};
 
-- 
2.1.4
