From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  6 May 2018 18:10:23 +0200
Subject: [PATCH 1/3] ARM: dts: s3c24xx: Remove skeleton.dtsi and fix DTC
 warning for /memory
Message-ID: <20180506161025.26937-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the usage of skeleton.dtsi to fix the DTC warning:

    arch/arm/boot/dts/s3c2416-smdk2416.dtb: Warning (unit_address_vs_reg):
        /memory: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c2416-smdk2416.dts | 3 ++-
 arch/arm/boot/dts/s3c24xx.dtsi         | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
index a1c9d8c695cc..5ef1144afceb 100644
--- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
+++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
@@ -12,7 +12,8 @@
 	model = "SMDK2416";
 	compatible = "samsung,s3c2416";
 
-	memory {
+	memory at 30000000 {
+		device_type = "memory";
 		reg =  <0x30000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/s3c24xx.dtsi b/arch/arm/boot/dts/s3c24xx.dtsi
index 34c7fe6751cf..6d8dd3cdd3c0 100644
--- a/arch/arm/boot/dts/s3c24xx.dtsi
+++ b/arch/arm/boot/dts/s3c24xx.dtsi
@@ -5,11 +5,11 @@
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
  */
 
-#include "skeleton.dtsi"
-
 / {
 	compatible = "samsung,s3c24xx";
 	interrupt-parent = <&intc>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	aliases {
 		pinctrl0 = &pinctrl_0;
-- 
2.14.1
