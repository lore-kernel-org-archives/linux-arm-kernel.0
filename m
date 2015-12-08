From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  8 Dec 2015 18:54:10 +0100
Subject: [PATCH 05/13] ARM: shmobile: genmai dts: Update console parameters
In-Reply-To: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
References: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1449597258-32623-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the console alias to "serial0", for consistency with other
boards (the first unlabeled serial port is always called "serial0").
Add serial port config to chosen/stdout-path.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r7s72100-genmai.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index a9da7a89fc4ba65a..47533c2c419e164d 100644
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
 
 	memory {
-- 
1.9.1
