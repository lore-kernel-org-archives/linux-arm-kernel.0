From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 12 Feb 2015 10:43:16 +0100
Subject: [PATCH v2] ARM: dts: zynq: Fix stdout-path and bootargs
Message-ID: <a9a55b576d88ef1f2ab6a1d1f6707d56104db32b.1423734193.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

parallella - Remove linux,stdout-path.
Use stdout-path to identify kernel console

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Remove linux,stdout-path reported by Mark Rutland
- Use stdout-path new console description with setting
- Change patch subject from "ARM: dts: zynq: Add linux,stdout-path and
  stdout-path"
- Do not add 1/2 patch which added aliases node to zybo and parallella

 arch/arm/boot/dts/zynq-parallella.dts | 4 ++--
 arch/arm/boot/dts/zynq-zc702.dts      | 3 ++-
 arch/arm/boot/dts/zynq-zc706.dts      | 3 ++-
 arch/arm/boot/dts/zynq-zed.dts        | 3 ++-
 arch/arm/boot/dts/zynq-zybo.dts       | 3 ++-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 6a5f51daa708..e1e5b2423d26 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -34,8 +34,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
-		linux,stdout-path = "/amba/serial at e0001000";
+		bootargs = "earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
+		stdout-path = "serial0:115200n8";
 	};
 };
 
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 1fc1d3911e9b..fb59d34e8ee6 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -30,7 +30,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyPS0,115200 earlyprintk";
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 850518d9b8ac..abf5d238ae04 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -30,7 +30,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyPS0,115200 earlyprintk";
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	usb_phy0: phy0 {
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 5658bc8434de..b9f2522012e8 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -29,7 +29,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyPS0,115200 earlyprintk";
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	usb_phy0: phy0 {
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index 935a561f6aa6..16c9cacd668d 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -29,7 +29,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyPS0,115200 earlyprintk";
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 };
-- 
1.8.2.3
