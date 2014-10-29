From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:19 +0900
Subject: [PATCH 13/19] ARM: shmobile: marzen dts: Add chosen/stdout-path
In-Reply-To: <cover.1414556943.git.horms+renesas@verge.net.au>
References: <cover.1414556943.git.horms+renesas@verge.net.au>
Message-ID: <1877a35096a3aebd6e848b688f8a50b75882b7e3.1414556944.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a stdout-path property so that automatic console selection works
in the absence of a "console=" parameter on the kernel command line.

Note that we have to keep the "console=" parameter in chosen/bootargs,
as this DTS is shared between legacy and multi-platform.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index c160404..9e1b859 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -25,6 +25,7 @@
 
 	chosen {
 		bootargs = "console=ttySC2,115200 ignore_loglevel root=/dev/nfs ip=on";
+		stdout-path = &scif2;
 	};
 
 	memory {
-- 
2.1.1
