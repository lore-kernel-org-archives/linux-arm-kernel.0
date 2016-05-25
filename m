From: vigneshr@ti.com (Vignesh R)
Date: Wed, 25 May 2016 15:16:50 +0530
Subject: [PATCH] ARM: dts: keystone-k2*: Increase SPI Flash partition size for
 U-Boot
Message-ID: <20160525094650.6169-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

U-Boot SPI Boot image is now more than 512KB for Keystone2 devices and
cannot fit into existing partition. So, increase the SPI Flash partition
for U-Boot to 1MB for all Keystone2 devices.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/keystone-k2e-evm.dts  | 4 ++--
 arch/arm/boot/dts/keystone-k2hk-evm.dts | 4 ++--
 arch/arm/boot/dts/keystone-k2l-evm.dts  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
index 4c32ebc1425a..39c91185e112 100644
--- a/arch/arm/boot/dts/keystone-k2e-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
@@ -129,13 +129,13 @@
 
 		partition at 0 {
 			label = "u-boot-spl";
-			reg = <0x0 0x80000>;
+			reg = <0x0 0x100000>;
 			read-only;
 		};
 
 		partition at 1 {
 			label = "misc";
-			reg = <0x80000 0xf80000>;
+			reg = <0x100000 0xf00000>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
index b38b3441818b..afc70d0481d4 100644
--- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
@@ -157,13 +157,13 @@
 
 		partition at 0 {
 			label = "u-boot-spl";
-			reg = <0x0 0x80000>;
+			reg = <0x0 0x100000>;
 			read-only;
 		};
 
 		partition at 1 {
 			label = "misc";
-			reg = <0x80000 0xf80000>;
+			reg = <0x100000 0xf00000>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
index 7f9c2e94d605..cabbdf69ddf5 100644
--- a/arch/arm/boot/dts/keystone-k2l-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
@@ -106,13 +106,13 @@
 
 		partition at 0 {
 			label = "u-boot-spl";
-			reg = <0x0 0x80000>;
+			reg = <0x0 0x100000>;
 			read-only;
 		};
 
 		partition at 1 {
 			label = "misc";
-			reg = <0x80000 0xf80000>;
+			reg = <0x100000 0xf00000>;
 		};
 	};
 };
-- 
2.8.3
