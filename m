From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  8 Dec 2015 18:54:14 +0100
Subject: [PATCH 09/13] ARM: shmobile: kzm9g dts: Update console parameters
In-Reply-To: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
References: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1449597258-32623-10-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the console alias to "serial0", for consistency with other
boards (the first unlabeled serial port is always called "serial0").
Drop the "console=" parameters from the kernel command line, as they're
no longer needed for DT-based platforms.
Add the serial port config to chosen/stdout-path.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index aa8bae3b8fcff6d6..554b275b1de50929 100644
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
 
 	memory {
@@ -345,7 +345,7 @@
 		};
 	};
 
-	scifa4_pins: serial4 {
+	scifa4_pins: serial0 {
 		renesas,groups = "scifa4_data", "scifa4_ctrl";
 		renesas,function = "scifa4";
 	};
-- 
1.9.1
