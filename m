From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun,  6 Nov 2016 23:27:09 +0100
Subject: [PATCH 16/19] ARM: dts: armada-370-xp: Fixup memory DT warning
In-Reply-To: <20161106222712.27366-1-gregory.clement@free-electrons.com>
References: <20161106222712.27366-1-gregory.clement@free-electrons.com>
Message-ID: <20161106222712.27366-17-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

memory has a reg property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts           | 2 +-
 arch/arm/boot/dts/armada-370-mirabox.dts                 | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts           | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts           | 2 +-
 arch/arm/boot/dts/armada-370-rd.dts                      | 2 +-
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi       | 2 +-
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi | 2 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts         | 2 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts                | 2 +-
 arch/arm/boot/dts/armada-xp-db.dts                       | 2 +-
 arch/arm/boot/dts/armada-xp-gp.dts                       | 2 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts          | 2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts            | 2 +-
 arch/arm/boot/dts/armada-xp-matrix.dts                   | 2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts           | 2 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts         | 2 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts           | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 6cfd827272bb..4e081723cc25 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -67,7 +67,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x40000000>; /* 1 GB */
 	};
diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
index 42d2b1077d42..ec154f170ac7 100644
--- a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -62,7 +62,7 @@
 		stdout-path = &uart0;
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>; /* 512 MiB */
 	};
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index e2880bed9339..f01e332deb70 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -54,7 +54,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 39c00013ac61..273db24d57b7 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -56,7 +56,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 741a9be59a8a..c12e8ab9e037 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -56,7 +56,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index cb016f43789e..8223e0aefac8 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -67,7 +67,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index 58a9455e978e..15d6aee02e17 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -23,7 +23,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index 7c0252a830a2..f77a08ebe7b6 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -24,7 +24,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index 4e71a3524ed4..2cf02f286391 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -70,7 +70,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index aa9974e3e72d..4c199ef539c1 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -62,7 +62,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x00000000 0x00000000 0x40000000>; /* 1GB */
 	};
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 697784557931..3f8807a60b04 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -67,7 +67,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0 0x00000000 0 0x80000000>; /* 2 GB */
 	};
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 3fcae0e47d9c..39235d5d055a 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -68,7 +68,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		/*
                  * 8 GB of plug-in RAM modules by default.The amount
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 33dcb56486f1..085f6362305a 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -57,7 +57,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0 0x00000000 0 0x20000000>; /* 512MB */
 	};
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index ce86ceab9289..fa1a84b20268 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -62,7 +62,7 @@
 		stdout-path = &uart0;
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x00000000 0x00000000 0x10000000>; /* 256MB */
 	};
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index e202890780c2..1edbf8bcb787 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -55,7 +55,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		/*
 		 * This board has 4 GB of RAM, but the last 256 MB of
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index df7e196bbc37..cdab131cb7c2 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -56,7 +56,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0 0x00000000 0 0x80000000>; /* 2GB */
 	};
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 3d1c533605ce..cf7b6759baf1 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -57,7 +57,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0 0x00000000 0 0x40000000>; /* 1 GB soldered on */
 	};
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index 43e501f2c307..91cd30946d91 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -70,7 +70,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0 0x00000000 0 0x40000000>; /* 1GB */
 	};
-- 
2.10.1
