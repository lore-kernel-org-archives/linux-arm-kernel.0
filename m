From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  8 Dec 2015 18:54:08 +0100
Subject: [PATCH 03/13] ARM: shmobile: armadillo800eva dts: Update console
 parameters
In-Reply-To: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
References: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1449597258-32623-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the console alias to "serial0", for consistency with other
boards (the first unlabeled serial port is always called "serial0").
Drop the "console=" parameters from the kernel command line, as they're
no longer needed for DT-based platforms.
Add the serial port config to chosen/stdout-path.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 78a21f2828dff6d1..296a0d1c1fe266c7 100644
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
 
 	memory {
@@ -232,7 +232,7 @@
 		renesas,function = "gether";
 	};
 
-	scifa1_pins: serial1 {
+	scifa1_pins: serial0 {
 		renesas,groups = "scifa1_data";
 		renesas,function = "scifa1";
 	};
-- 
1.9.1
