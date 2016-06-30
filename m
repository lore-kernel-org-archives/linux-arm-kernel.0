From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:53 +0200
Subject: [PATCH 33/41] ARM: dts: genmai: Update console parameters
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <be6bebae60a354bcc207d1b99077c87f1a344710.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Change the console alias to "serial0", for consistency with other
boards (the first unlabeled serial port is always called "serial0").
This does change the serial console from /dev/ttySC2 to /dev/ttySC0.
Add the serial port config to "chosen/stdout-path", which requires
referring to the port by alias.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-genmai.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index 05ba9953b4d8..118a8e2b86bd 100644
--- a/arch/arm/boot/dts/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai.dts
@@ -17,12 +17,12 @@
 	compatible = "renesas,genmai", "renesas,r7s72100";
 
 	aliases {
-		serial2 = &scif2;
+		serial0 = &scif2;
 	};
 
 	chosen {
 		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = &scif2;
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory at 8000000 {
-- 
2.7.0.rc3.207.g0ac5344
