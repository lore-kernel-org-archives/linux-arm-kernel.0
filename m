From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue,  3 Apr 2012 09:32:57 +0200
Subject: [PATCH v2 13/13] ARM: at91: dt: remove unit-address part for memory
 nodes
In-Reply-To: <cover.1333437885.git.nicolas.ferre@atmel.com>
References: <cover.1333437885.git.nicolas.ferre@atmel.com>
Message-ID: <1db62b280314855c35cb7a3188fc9d9cb8501948.1333437885.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Having a unit-address different from 0 causes bad memory node detection
during early_init_dt_scan_memory.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/boot/dts/at91sam9g20.dtsi     |    2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi     |    2 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts |    2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi      |    2 +-
 arch/arm/boot/dts/at91sam9x5cm.dtsi    |    2 +-
 arch/arm/boot/dts/usb_a9g20.dts        |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 92f3662..799ad18 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -35,7 +35,7 @@
 		};
 	};
 
-	memory at 20000000 {
+	memory {
 		reg = <0x20000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 3d0c32f..9e6eb6e 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -36,7 +36,7 @@
 		};
 	};
 
-	memory at 70000000 {
+	memory {
 		reg = <0x70000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 6abb571..a3633bd 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -17,7 +17,7 @@
 		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=jffs2";
 	};
 
-	memory at 70000000 {
+	memory {
 		reg = <0x70000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 6597177..70ab3a4 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -34,7 +34,7 @@
 		};
 	};
 
-	memory at 20000000 {
+	memory {
 		reg = <0x20000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index 67936f8..31e7be2 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -8,7 +8,7 @@
  */
 
 / {
-	memory at 20000000 {
+	memory {
 		reg = <0x20000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 3b3c4e0..7c2399c 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -16,7 +16,7 @@
 		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
 	};
 
-	memory at 20000000 {
+	memory {
 		reg = <0x20000000 0x4000000>;
 	};
 
-- 
1.7.9.4
