From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  6 May 2018 18:10:25 +0200
Subject: [PATCH 3/3] ARM: dts: s3c64xx: Remove skeleton.dtsi and fix DTC
 warnings for /memory
In-Reply-To: <20180506161025.26937-1-krzk@kernel.org>
References: <20180506161025.26937-1-krzk@kernel.org>
Message-ID: <20180506161025.26937-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the usage of skeleton.dtsi to fix the DTC warnings:

    arch/arm/boot/dts/s3c6410-mini6410.dtb: Warning (unit_address_vs_reg):
        /memory: node has a reg or ranges property, but no unit name
    arch/arm/boot/dts/s3c6410-smdk6410.dtb: Warning (unit_address_vs_reg):
        /memory: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c6410-mini6410.dts | 3 ++-
 arch/arm/boot/dts/s3c6410-smdk6410.dts | 3 ++-
 arch/arm/boot/dts/s3c64xx.dtsi         | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index f68601bd9c91..0e159c884f97 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -19,7 +19,8 @@
 	model = "FriendlyARM Mini6410 board based on S3C6410";
 	compatible = "friendlyarm,mini6410", "samsung,s3c6410";
 
-	memory {
+	memory at 50000000 {
+		device_type = "memory";
 		reg = <0x50000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/s3c6410-smdk6410.dts b/arch/arm/boot/dts/s3c6410-smdk6410.dts
index b6b5afcd7602..a9a5689dc462 100644
--- a/arch/arm/boot/dts/s3c6410-smdk6410.dts
+++ b/arch/arm/boot/dts/s3c6410-smdk6410.dts
@@ -19,7 +19,8 @@
 	model = "SAMSUNG SMDK6410 board based on S3C6410";
 	compatible = "samsung,mini6410", "samsung,s3c6410";
 
-	memory {
+	memory at 50000000 {
+		device_type = "memory";
 		reg = <0x50000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index e2be3fbdd3f3..2e611df37911 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -13,10 +13,12 @@
  * nodes can be added to this file.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/samsung,s3c64xx-clock.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		i2c0 = &i2c0;
 		pinctrl0 = &pinctrl0;
-- 
2.14.1
