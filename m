From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 11 Nov 2012 10:09:26 +0530
Subject: [PATCH 04/14] ARM: SPEAr: DT: Update partition info for MTD devices
In-Reply-To: <cover.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <5530adca95f45d44153f9c905cbbd7c97b0c4c75.1352608333.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipin Kumar <vipin.kumar@st.com>

This patch enhances partition information of MTD devices like fsmc-nand and
spear-smi.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/spear1310-evb.dts | 43 ++++++++++++++++++++++++++++++++-----
 arch/arm/boot/dts/spear1340-evb.dts | 43 ++++++++++++++++++++++++++++++++-----
 arch/arm/boot/dts/spear300-evb.dts  | 18 +++++++++++-----
 arch/arm/boot/dts/spear310-evb.dts  | 18 +++++++++++-----
 arch/arm/boot/dts/spear320-evb.dts  | 18 +++++++++++-----
 arch/arm/boot/dts/spear600-evb.dts  | 18 +++++++++++-----
 6 files changed, 128 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index 08697ac..2e2887b 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -120,6 +120,31 @@
 
 		fsmc: flash at b0000000 {
 			status = "okay";
+
+			partition at 0 {
+				label = "xloader";
+				reg = <0x0 0x80000>;
+			};
+			partition at 80000 {
+				label = "u-boot";
+				reg = <0x80000 0x140000>;
+			};
+			partition at 1C0000 {
+				label = "environment";
+				reg = <0x1C0000 0x40000>;
+			};
+			partition at 200000 {
+				label = "dtb";
+				reg = <0x200000 0x40000>;
+			};
+			partition at 240000 {
+				label = "linux";
+				reg = <0x240000 0xC00000>;
+			};
+			partition at E40000 {
+				label = "rootfs";
+				reg = <0xE40000 0x0>;
+			};
 		};
 
 		gmac0: eth at e2000000 {
@@ -146,15 +171,23 @@
 				};
 				partition at 10000 {
 					label = "u-boot";
-					reg = <0x10000 0x40000>;
+					reg = <0x10000 0x50000>;
+				};
+				partition at 60000 {
+					label = "environment";
+					reg = <0x60000 0x10000>;
+				};
+				partition at 70000 {
+					label = "dtb";
+					reg = <0x70000 0x10000>;
 				};
-				partition at 50000 {
+				partition at 80000 {
 					label = "linux";
-					reg = <0x50000 0x2c0000>;
+					reg = <0x80000 0x310000>;
 				};
-				partition at 310000 {
+				partition at 390000 {
 					label = "rootfs";
-					reg = <0x310000 0x4f0000>;
+					reg = <0x390000 0x0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index 8e35c14..8d6339d 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -128,6 +128,31 @@
 
 		fsmc: flash at b0000000 {
 			status = "okay";
+
+			partition at 0 {
+				label = "xloader";
+				reg = <0x0 0x200000>;
+			};
+			partition at 200000 {
+				label = "u-boot";
+				reg = <0x200000 0x200000>;
+			};
+			partition at 400000 {
+				label = "environment";
+				reg = <0x400000 0x100000>;
+			};
+			partition at 500000 {
+				label = "dtb";
+				reg = <0x500000 0x100000>;
+			};
+			partition at 600000 {
+				label = "linux";
+				reg = <0x600000 0xC00000>;
+			};
+			partition at 1200000 {
+				label = "rootfs";
+				reg = <0x1200000 0x0>;
+			};
 		};
 
 		gmac0: eth at e2000000 {
@@ -154,15 +179,23 @@
 				};
 				partition at 10000 {
 					label = "u-boot";
-					reg = <0x10000 0x40000>;
+					reg = <0x10000 0x50000>;
+				};
+				partition at 60000 {
+					label = "environment";
+					reg = <0x60000 0x10000>;
+				};
+				partition at 70000 {
+					label = "dtb";
+					reg = <0x70000 0x10000>;
 				};
-				partition at 50000 {
+				partition at 80000 {
 					label = "linux";
-					reg = <0x50000 0x2c0000>;
+					reg = <0x80000 0x310000>;
 				};
-				partition at 310000 {
+				partition at 390000 {
 					label = "rootfs";
-					reg = <0x310000 0x4f0000>;
+					reg = <0x390000 0x0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/spear300-evb.dts b/arch/arm/boot/dts/spear300-evb.dts
index 1e7c7a8..b3265f6 100644
--- a/arch/arm/boot/dts/spear300-evb.dts
+++ b/arch/arm/boot/dts/spear300-evb.dts
@@ -100,15 +100,23 @@
 				};
 				partition at 10000 {
 					label = "u-boot";
-					reg = <0x10000 0x40000>;
+					reg = <0x10000 0x50000>;
 				};
-				partition at 50000 {
+				partition at 60000 {
+					label = "environment";
+					reg = <0x60000 0x10000>;
+				};
+				partition at 70000 {
+					label = "dtb";
+					reg = <0x70000 0x10000>;
+				};
+				partition at 80000 {
 					label = "linux";
-					reg = <0x50000 0x2c0000>;
+					reg = <0x80000 0x310000>;
 				};
-				partition at 310000 {
+				partition at 390000 {
 					label = "rootfs";
-					reg = <0x310000 0x4f0000>;
+					reg = <0x390000 0x0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/spear310-evb.dts b/arch/arm/boot/dts/spear310-evb.dts
index b00544e..b30fa0e 100644
--- a/arch/arm/boot/dts/spear310-evb.dts
+++ b/arch/arm/boot/dts/spear310-evb.dts
@@ -114,15 +114,23 @@
 				};
 				partition at 10000 {
 					label = "u-boot";
-					reg = <0x10000 0x40000>;
+					reg = <0x10000 0x50000>;
 				};
-				partition at 50000 {
+				partition at 60000 {
+					label = "environment";
+					reg = <0x60000 0x10000>;
+				};
+				partition at 70000 {
+					label = "dtb";
+					reg = <0x70000 0x10000>;
+				};
+				partition at 80000 {
 					label = "linux";
-					reg = <0x50000 0x2c0000>;
+					reg = <0x80000 0x310000>;
 				};
-				partition at 310000 {
+				partition at 390000 {
 					label = "rootfs";
-					reg = <0x310000 0x4f0000>;
+					reg = <0x390000 0x0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
index 3f87cd0..a3061ad 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -118,15 +118,23 @@
 				};
 				partition at 10000 {
 					label = "u-boot";
-					reg = <0x10000 0x40000>;
+					reg = <0x10000 0x50000>;
 				};
-				partition at 50000 {
+				partition at 60000 {
+					label = "environment";
+					reg = <0x60000 0x10000>;
+				};
+				partition at 70000 {
+					label = "dtb";
+					reg = <0x70000 0x10000>;
+				};
+				partition at 80000 {
 					label = "linux";
-					reg = <0x50000 0x2c0000>;
+					reg = <0x80000 0x310000>;
 				};
-				partition at 310000 {
+				partition at 390000 {
 					label = "rootfs";
-					reg = <0x310000 0x4f0000>;
+					reg = <0x390000 0x0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/spear600-evb.dts b/arch/arm/boot/dts/spear600-evb.dts
index 1119c22..16e4de4 100644
--- a/arch/arm/boot/dts/spear600-evb.dts
+++ b/arch/arm/boot/dts/spear600-evb.dts
@@ -49,15 +49,23 @@
 				};
 				partition at 10000 {
 					label = "u-boot";
-					reg = <0x10000 0x40000>;
+					reg = <0x10000 0x50000>;
 				};
-				partition at 50000 {
+				partition at 60000 {
+					label = "environment";
+					reg = <0x60000 0x10000>;
+				};
+				partition at 70000 {
+					label = "dtb";
+					reg = <0x70000 0x10000>;
+				};
+				partition at 80000 {
 					label = "linux";
-					reg = <0x50000 0x2c0000>;
+					reg = <0x80000 0x310000>;
 				};
-				partition at 310000 {
+				partition at 390000 {
 					label = "rootfs";
-					reg = <0x310000 0x4f0000>;
+					reg = <0x390000 0x0>;
 				};
 			};
 		};
-- 
1.7.12.rc2.18.g61b472e
