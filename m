From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  5 Nov 2018 19:14:45 -0200
Subject: [PATCH v2 1/2] ARM: dts: imx51: Fix memory node duplicaton
Message-ID: <1541452486-26597-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards based on imx51 have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx51.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/imx51-apf51.dts                 | 1 +
 arch/arm/boot/dts/imx51-babbage.dts               | 1 +
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi | 1 +
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi      | 1 +
 arch/arm/boot/dts/imx51-ts4800.dts                | 1 +
 arch/arm/boot/dts/imx51-zii-rdu1.dts              | 1 +
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts         | 1 +
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts          | 1 +
 arch/arm/boot/dts/imx51.dtsi                      | 2 --
 9 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-apf51.dts b/arch/arm/boot/dts/imx51-apf51.dts
index 79d8003..1eddf29 100644
--- a/arch/arm/boot/dts/imx51-apf51.dts
+++ b/arch/arm/boot/dts/imx51-apf51.dts
@@ -22,6 +22,7 @@
 	compatible = "armadeus,imx51-apf51", "fsl,imx51";
 
 	memory at 90000000 {
+		device_type = "memory";
 		reg = <0x90000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 35ee1b4..ed6a3ce 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -15,6 +15,7 @@
 	};
 
 	memory at 90000000 {
+		device_type = "memory";
 		reg = <0x90000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
index 5761a66..82d8df0 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
@@ -17,6 +17,7 @@
 	compatible = "digi,connectcore-ccxmx51-som", "fsl,imx51";
 
 	memory at 90000000 {
+		device_type = "memory";
 		reg = <0x90000000 0x08000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
index f8902a3..2e31253 100644
--- a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
+++ b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
@@ -23,6 +23,7 @@
 	compatible = "eukrea,cpuimx51", "fsl,imx51";
 
 	memory at 90000000 {
+		device_type = "memory";
 		reg = <0x90000000 0x10000000>; /* 256M */
 	};
 };
diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index 39eb067..4344632 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -18,6 +18,7 @@
 	};
 
 	memory at 90000000 {
+		device_type = "memory";
 		reg = <0x90000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index e45a15c..3ca4f9b 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -53,6 +53,7 @@
 
 	/* Will be filled by the bootloader */
 	memory at 90000000 {
+		device_type = "memory";
 		reg = <0x90000000 0>;
 	};
 
diff --git a/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts b/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
index 243d1c8..aa91e5d 100644
--- a/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
@@ -18,6 +18,7 @@
 
 	/* Will be filled by the bootloader */
 	memory at 90000000 {
+		device_type = "memory";
 		reg = <0x90000000 0>;
 	};
 
diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
index 14b2077..875b10a 100644
--- a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
@@ -18,6 +18,7 @@
 
 	/* Will be filled by the bootloader */
 	memory at 90000000 {
+		device_type = "memory";
 		reg = <0x90000000 0>;
 	};
 
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 67d4627..7651bed 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -16,10 +16,8 @@
 	 * The decompressor and also some bootloaders rely on a
 	 * pre-existing /chosen node to be available to insert the
 	 * command line and merge other ATAGS info.
-	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
-- 
2.7.4
