From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 9 Oct 2015 17:10:36 +0100
Subject: [PATCH] ARM: hisilicon: DT: Drop console= and earlyprintk bootargs
 parameter
Message-ID: <5617E6FC.6090304@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace console with stdout-path so that we don't have to put the
console on the kernel command line.

Remove earlyprintk to allow the kernel to boot on a system even
if DEBUG_LL is configured for another system.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 arch/arm/boot/dts/hi3620-hi4511.dts  | 3 ++-
 arch/arm/boot/dts/hisi-x5hd2-dkb.dts | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/hi3620-hi4511.dts b/arch/arm/boot/dts/hi3620-hi4511.dts
index fe62392..a579fbf 100644
--- a/arch/arm/boot/dts/hi3620-hi4511.dts
+++ b/arch/arm/boot/dts/hi3620-hi4511.dts
@@ -16,7 +16,8 @@
     compatible = "hisilicon,hi3620-hi4511";

     chosen {
-        bootargs = "console=ttyAMA0,115200 root=/dev/ram0 earlyprintk";
+        bootargs = "root=/dev/ram0";
+        stdout-path = "serial0:115200n8";
     };

     memory {
diff --git a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
index 721b092..d13af84 100644
--- a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
+++ b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
@@ -15,7 +15,7 @@
     compatible = "hisilicon,hix5hd2";

     chosen {
-        bootargs = "console=ttyAMA0,115200 earlyprintk";
+        stdout-path = "serial0:115200n8";
     };

     cpus {
-- 1.9.1
