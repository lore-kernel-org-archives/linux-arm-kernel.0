From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  6 May 2018 18:10:24 +0200
Subject: [PATCH 2/3] ARM: dts: s3c24xx: Fix unnecessary address/size cells DTC
 warnings
In-Reply-To: <20180506161025.26937-1-krzk@kernel.org>
References: <20180506161025.26937-1-krzk@kernel.org>
Message-ID: <20180506161025.26937-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix DTC warnings:

    arch/arm/boot/dts/s3c2416-smdk2416.dtb: Warning (avoid_unnecessary_addr_size):
        /cpus: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
    arch/arm/boot/dts/s3c2416-smdk2416.dtb: Warning (avoid_unnecessary_addr_size):
        /clocks: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c2416-smdk2416.dts | 2 --
 arch/arm/boot/dts/s3c2416.dtsi         | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
index 5ef1144afceb..5164386aff3a 100644
--- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
+++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
@@ -19,8 +19,6 @@
 
 	clocks {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
 
 		xti: xti {
 			compatible = "fixed-clock";
diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index 46cf85f3c18b..6adf64ea3ff2 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -18,9 +18,6 @@
 	};
 
 	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		cpu {
 			compatible = "arm,arm926ej-s";
 		};
-- 
2.14.1
