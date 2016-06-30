From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:52 +0200
Subject: [PATCH 32/41] ARM: dts: armadillo800eva: Update console parameters
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <1403e38b829acdad5679862a5949e408bca2279a.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Change the console alias to "serial0", for consistency with other
boards (the first unlabeled serial port is always called "serial0").
This does change the serial console from /dev/ttySC1 to /dev/ttySC0.
Add the serial port config to "chosen/stdout-path", which requires
referring to the port by alias.
Drop the "console=" parameters from the kernel command line, as they're
no longer needed for DT-based platforms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 6866f61a350c..7885075428bb 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -20,12 +20,12 @@
 	compatible = "renesas,armadillo800eva", "renesas,r8a7740";
 
 	aliases {
-		serial1 = &scifa1;
+		serial0 = &scifa1;
 	};
 
 	chosen {
-		bootargs = "console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
-		stdout-path = &scifa1;
+		bootargs = "earlyprintk ignore_loglevel root=/dev/nfs ip=dhcp rw";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory at 40000000 {
-- 
2.7.0.rc3.207.g0ac5344
