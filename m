From: vwadekar@nvidia.com (Varun Wadekar)
Date: Tue, 15 Nov 2011 11:51:27 +0530
Subject: [PATCH v1] dts: tegra-ventana: use proper root instead of /dev/ram
Message-ID: <1321338087-3662-1-git-send-email-vwadekar@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pritesh Raithatha <praithatha@nvidia.com>

The root file system on ventana resides on /dev/mmcblk0p1.
Update the dts file to use the proper root instead of /dev/ram.

Signed-off-by: Pritesh Raithatha <praithatha@nvidia.com>
Signed-off-by: Varun Wadekar <vwadekar@nvidia.com>
---
 arch/arm/boot/dts/tegra-ventana.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index 9b29a62..5f7fe74 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -8,7 +8,7 @@
 	compatible = "nvidia,ventana", "nvidia,tegra20";
 
 	chosen {
-		bootargs = "vmalloc=192M video=tegrafb console=ttyS0,115200n8 root=/dev/ram rdinit=/sbin/init";
+		bootargs = "vmalloc=192M video=tegrafb console=ttyS0,115200n8 root=/dev/mmcblk0p1 rw rootwait";
 	};
 
 	memory {
-- 
1.7.1
