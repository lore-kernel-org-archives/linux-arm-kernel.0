From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:56 +0200
Subject: [PATCH 36/41] ARM: dts: kzm9g: Update console parameters
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <54389e981cdfd081de67de083df451b70651f821.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Change the console alias to "serial0", for consistency with other
boards (the first unlabeled serial port is always called "serial0").
This does change the serial console from /dev/ttySC4 to /dev/ttySC0.
Add the serial port config to "chosen/stdout-path", which requires
referring to the port by alias.
Drop the "console=" parameters from the kernel command line, as they're
no longer needed for DT-based platforms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 1df68b167033..3d65f1f6d78b 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -22,7 +22,7 @@
 	compatible = "renesas,kzm9g", "renesas,sh73a0";
 
 	aliases {
-		serial4 = &scifa4;
+		serial0 = &scifa4;
 	};
 
 	cpus {
@@ -39,8 +39,8 @@
 	};
 
 	chosen {
-		bootargs = "console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel rw";
-		stdout-path = &scifa4;
+		bootargs = "root=/dev/nfs ip=dhcp ignore_loglevel rw";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory at 40000000 {
-- 
2.7.0.rc3.207.g0ac5344
