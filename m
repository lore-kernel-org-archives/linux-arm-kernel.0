From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 11 Feb 2015 13:29:02 +0100
Subject: [PATCH 2/2] ARM: dts: zynq: Add linux,stdout-path and stdout-path
In-Reply-To: <0a0e0579fb6e2794d2c0c6fb9186c5b43618f448.1423657710.git.michal.simek@xilinx.com>
References: <0a0e0579fb6e2794d2c0c6fb9186c5b43618f448.1423657710.git.michal.simek@xilinx.com>
Message-ID: <ea777ffbffea442e3bc69fe11183811772a5716e.1423657710.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

parallella - Use reference instead of hardcoded path
             (linux,stdout-path)

stdout-path is used by bootloader to identify console.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

U-Boot driver model requires stdout-path.
---
 arch/arm/boot/dts/zynq-parallella.dts | 3 ++-
 arch/arm/boot/dts/zynq-zc702.dts      | 2 ++
 arch/arm/boot/dts/zynq-zc706.dts      | 2 ++
 arch/arm/boot/dts/zynq-zed.dts        | 2 ++
 arch/arm/boot/dts/zynq-zybo.dts       | 2 ++
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 6a5f51daa708..45228a427006 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -35,7 +35,8 @@
 
 	chosen {
 		bootargs = "console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
-		linux,stdout-path = "/amba/serial at e0001000";
+		linux,stdout-path = &uart1;
+		stdout-path = &uart1;
 	};
 };
 
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 1fc1d3911e9b..205c7c472bac 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -31,6 +31,8 @@
 
 	chosen {
 		bootargs = "console=ttyPS0,115200 earlyprintk";
+		linux,stdout-path = &uart1;
+		stdout-path = &uart1;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 850518d9b8ac..f624747719dd 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -31,6 +31,8 @@
 
 	chosen {
 		bootargs = "console=ttyPS0,115200 earlyprintk";
+		linux,stdout-path = &uart1;
+		stdout-path = &uart1;
 	};
 
 	usb_phy0: phy0 {
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 5658bc8434de..a957159104ea 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -30,6 +30,8 @@
 
 	chosen {
 		bootargs = "console=ttyPS0,115200 earlyprintk";
+		linux,stdout-path = &uart1;
+		stdout-path = &uart1;
 	};
 
 	usb_phy0: phy0 {
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index 935a561f6aa6..e51f889f7fc7 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -30,6 +30,8 @@
 
 	chosen {
 		bootargs = "console=ttyPS0,115200 earlyprintk";
+		linux,stdout-path = &uart1;
+		stdout-path = &uart1;
 	};
 
 };
-- 
1.8.2.3
