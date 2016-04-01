From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 01 Apr 2016 16:11:50 +0900
Subject: [PATCH] ARM: dts: s3c: Fix DTC unit name warnings in S3C2416 and
 S3C6410
Message-ID: <1459494710-16269-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following DTC warnings in S3C2416 and S3C6410 boards:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/s3c2416-smdk2416.dts | 2 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts | 2 +-
 arch/arm/boot/dts/s3c6410-smdk6410.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
index f257926c13b7..15f3d1c1bb80 100644
--- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
+++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
@@ -15,7 +15,7 @@
 	model = "SMDK2416";
 	compatible = "samsung,s3c2416";
 
-	memory {
+	memory at 30000000 {
 		reg =  <0x30000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index a25debb50401..b7d84cf816c2 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -22,7 +22,7 @@
 	model = "FriendlyARM Mini6410 board based on S3C6410";
 	compatible = "friendlyarm,mini6410", "samsung,s3c6410";
 
-	memory {
+	memory at 50000000 {
 		reg = <0x50000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/s3c6410-smdk6410.dts b/arch/arm/boot/dts/s3c6410-smdk6410.dts
index ecf35ec466f7..dbebd58a4764 100644
--- a/arch/arm/boot/dts/s3c6410-smdk6410.dts
+++ b/arch/arm/boot/dts/s3c6410-smdk6410.dts
@@ -22,7 +22,7 @@
 	model = "SAMSUNG SMDK6410 board based on S3C6410";
 	compatible = "samsung,mini6410", "samsung,s3c6410";
 
-	memory {
+	memory at 50000000 {
 		reg = <0x50000000 0x8000000>;
 	};
 
-- 
2.5.0
