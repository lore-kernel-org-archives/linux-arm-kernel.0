From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 15 Feb 2016 17:05:19 +0100
Subject: [PATCH 3/3] ARM: zynq: Use earlycon instead of earlyprintk
In-Reply-To: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
References: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
Message-ID: <8cd6d86437baf0a7a443f4d288a9c6a9df66ffc3.1455552315.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use early console instead of earlyprintk which is supposed to use for
very early debugging (DEBUG_LL).

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-parallella.dts | 2 +-
 arch/arm/boot/dts/zynq-zc702.dts      | 2 +-
 arch/arm/boot/dts/zynq-zc706.dts      | 2 +-
 arch/arm/boot/dts/zynq-zed.dts        | 2 +-
 arch/arm/boot/dts/zynq-zybo.dts       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 9efd16cb2859..307ed201d658 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -34,7 +34,7 @@
 	};
 
 	chosen {
-		bootargs = "earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
+		bootargs = "earlycon root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
 		stdout-path = "serial0:115200n8";
 	};
 };
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index cb64209bca08..e96959b2e67a 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -30,7 +30,7 @@
 	};
 
 	chosen {
-		bootargs = "earlyprintk";
+		bootargs = "earlycon";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index abf5d238ae04..be6a986bbbd8 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -30,7 +30,7 @@
 	};
 
 	chosen {
-		bootargs = "earlyprintk";
+		bootargs = "earlycon";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index b9f2522012e8..7250c1eac7f9 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -29,7 +29,7 @@
 	};
 
 	chosen {
-		bootargs = "earlyprintk";
+		bootargs = "earlycon";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index 16c9cacd668d..bd992e036aa9 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -29,7 +29,7 @@
 	};
 
 	chosen {
-		bootargs = "earlyprintk";
+		bootargs = "earlycon";
 		stdout-path = "serial0:115200n8";
 	};
 
-- 
1.9.1
