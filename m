From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:16 +0900
Subject: [PATCH 10/19] ARM: shmobile: ape6evm-reference dts: Add
 chosen/stdout-path
In-Reply-To: <cover.1414556943.git.horms+renesas@verge.net.au>
References: <cover.1414556943.git.horms+renesas@verge.net.au>
Message-ID: <71787aaa6015c4b7f47126c053afd8f2bebb00d7.1414556944.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a stdout-path property so that automatic console selection works
in the absence of a "console=" parameter on the kernel command line.
In addition, this will allow the PM domain code to find the PM domain
for the console device.

Remove the now-superfluous "console=" parameter from chosen/bootargs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index a860f32..2bcf691 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -21,7 +21,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySC0,115200 ignore_loglevel rw";
+		bootargs = "ignore_loglevel rw";
+		stdout-path = &scifa0;
 	};
 
 	memory at 40000000 {
-- 
2.1.1
