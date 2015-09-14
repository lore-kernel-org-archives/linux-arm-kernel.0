From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 14 Sep 2015 14:42:13 +0800
Subject: [PATCH RESEND 2/2] arm: dts: berlin: use stdout-path
In-Reply-To: <1442212933-760-1-git-send-email-jszhang@marvell.com>
References: <1442212933-760-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442212933-760-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path to specify the console and remove the console argument
from the kernel command line.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        | 3 ++-
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 3 ++-
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts        | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
index 5c99fb3..3c0907b 100644
--- a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
+++ b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
@@ -45,7 +45,8 @@
 	compatible = "sony,nsz-gs7", "marvell,berlin2", "marvell,berlin";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
index 772165a..8ba8b50 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -46,7 +46,8 @@
 	compatible = "google,chromecast", "marvell,berlin2cd", "marvell,berlin";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 4a749e5..da28c97 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -49,7 +49,8 @@
 	};
 
 	choosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	regulators {
-- 
2.5.1
