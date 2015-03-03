From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  3 Mar 2015 15:41:02 +0100
Subject: [PATCH v3 07/20] ARM: mvebu: use stdout-path in all armada-*.dts
In-Reply-To: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1425393675-17820-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the stdout-path property in /chosen for all Armada
boards that were not yet carrying this property, and gets rid of
/chosen/bootargs which becomes unneeded: earlyprintk should not be
used by default, and the console= parameter is replaced by the
/chosen/stdout-path property.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts              | 2 +-
 arch/arm/boot/dts/armada-370-mirabox.dts         | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts   | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 2 +-
 arch/arm/boot/dts/armada-370-rd.dts              | 2 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts | 3 +--
 arch/arm/boot/dts/armada-375-db.dts              | 2 +-
 arch/arm/boot/dts/armada-385-db-ap.dts           | 3 +--
 arch/arm/boot/dts/armada-388-db.dts              | 2 +-
 arch/arm/boot/dts/armada-388-gp.dts              | 3 +--
 arch/arm/boot/dts/armada-388-rd.dts              | 2 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 2 +-
 arch/arm/boot/dts/armada-xp-db.dts               | 2 +-
 arch/arm/boot/dts/armada-xp-gp.dts               | 2 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  | 3 +--
 arch/arm/boot/dts/armada-xp-matrix.dts           | 2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 2 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 2 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts   | 3 +--
 19 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index e993c46..485ecf8 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -55,7 +55,7 @@
 	compatible = "marvell,a370-db", "marvell,armada370", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index b10ceb4..0f40d5d 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -51,7 +51,7 @@
 	compatible = "globalscale,mirabox", "marvell,armada370", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 3f8cc38..a312078 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -53,7 +53,7 @@
 	compatible = "netgear,readynas-102", "marvell,armada370", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 99eb8a0..00540f2 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -53,7 +53,7 @@
 	compatible = "netgear,readynas-104", "marvell,armada370", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 6ae36a3..19475e6 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -64,7 +64,7 @@
 	compatible = "marvell,a370-rd", "marvell,armada370", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index 59f74e6..b42b767 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -67,8 +67,7 @@
 		     "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
-		stdout-path = &uart0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index 0440891..4eabc9c 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -55,7 +55,7 @@
 	compatible = "marvell,a375-db", "marvell,armada375";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index 57b9119..779119f 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -49,8 +49,7 @@
 	compatible = "marvell,a385-db-ap", "marvell,armada385", "marvell,armada38x";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
-		stdout-path = &uart1;
+		stdout-path = "serial1:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index af6c74e..51d1623 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -54,7 +54,7 @@
 		"marvell,armada385", "marvell,armada380";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 3ff0573..78514ab 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -48,8 +48,7 @@
 	compatible = "marvell,a385-gp", "marvell,armada388", "marvell,armada380";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
-		stdout-path = &uart0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/armada-388-rd.dts
index d99baac..db99cae 100644
--- a/arch/arm/boot/dts/armada-388-rd.dts
+++ b/arch/arm/boot/dts/armada-388-rd.dts
@@ -55,7 +55,7 @@
 		"marvell,armada385","marvell,armada380";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index c1fbab2..dfd782b 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -59,7 +59,7 @@
 	compatible = "marvell,rd-axpwifiap", "marvell,armadaxp-mv78230", "marvell,armadaxp", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 48bdafe..1037824 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -64,7 +64,7 @@
 	compatible = "marvell,axp-db", "marvell,armadaxp-mv78460", "marvell,armadaxp", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 206aebb..565227e 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -65,7 +65,7 @@
 	compatible = "marvell,axp-gp", "marvell,armadaxp-mv78460", "marvell,armadaxp", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 5fb3c8b..06a6a6c 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -54,8 +54,7 @@
 		     "marvell,armadaxp", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
-		stdout-path = &uart0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index 56f958e..f894bc8 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -52,7 +52,7 @@
 	compatible = "marvell,axp-matrix", "marvell,armadaxp-mv78460", "marvell,armadaxp", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 99cb9a8..1516fc2 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -53,7 +53,7 @@
 	compatible = "netgear,readynas-2120", "marvell,armadaxp-mv78230", "marvell,armadaxp", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 0c76d9f..e3b08fb 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -54,7 +54,7 @@
 	compatible = "plathome,openblocks-ax3-4", "marvell,armadaxp-mv78260", "marvell,armadaxp", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index e9fb225..6063428 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -67,8 +67,7 @@
 		     "marvell,armadaxp", "marvell,armada-370-xp";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 earlyprintk";
-		stdout-path = &uart0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
2.1.0
