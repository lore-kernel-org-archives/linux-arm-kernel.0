From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  4 Aug 2017 13:07:03 +0200
Subject: [PATCH] ARM: zynq: Remove earlycon from bootargs
Message-ID: <dff4b3c7a291fca6648134f5c8950e7ec472eec0.1501844819.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Earlyconsole is used for early kernel debugging that's why this option
shouldn't be enabled by default.
Earlyconsole is partially copying the part of the bootlog after
"bootconsole [uart0] disabled".

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-parallella.dts | 2 +-
 arch/arm/boot/dts/zynq-zc702.dts      | 2 +-
 arch/arm/boot/dts/zynq-zc706.dts      | 2 +-
 arch/arm/boot/dts/zynq-zed.dts        | 2 +-
 arch/arm/boot/dts/zynq-zybo.dts       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 77f6f10bf685..0144acfa9793 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -34,7 +34,7 @@
 	};
 
 	chosen {
-		bootargs = "earlycon root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
+		bootargs = "root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
 		stdout-path = "serial0:115200n8";
 	};
 };
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index a096275d903d..34e8277fce0d 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -30,7 +30,7 @@
 	};
 
 	chosen {
-		bootargs = "earlycon";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 689ec9d6f7b9..7ebc8c5ae39d 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -30,7 +30,7 @@
 	};
 
 	chosen {
-		bootargs = "earlycon";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index c6a5749c8930..5e44dc12fd60 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -29,7 +29,7 @@
 	};
 
 	chosen {
-		bootargs = "earlycon";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index 8b42fb199a8e..e40cafc5ee5b 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -29,7 +29,7 @@
 	};
 
 	chosen {
-		bootargs = "earlycon";
+		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
 
-- 
1.9.1
