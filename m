From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Nov 2018 10:40:53 -0200
Subject: [PATCH 2/3] ARM: dts: imx27: Fix memory node duplicaton
In-Reply-To: <1543236054-10450-1-git-send-email-festevam@gmail.com>
References: <1543236054-10450-1-git-send-email-festevam@gmail.com>
Message-ID: <1543236054-10450-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards based on imx27 have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx27.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx27-apf27.dts                 | 1 +
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi      | 1 +
 arch/arm/boot/dts/imx27-pdk.dts                   | 1 +
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi | 1 +
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi   | 1 +
 arch/arm/boot/dts/imx27.dtsi                      | 2 --
 6 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index 3eddd80..f635d5c 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -20,6 +20,7 @@
 	compatible = "armadeus,imx27-apf27", "fsl,imx27";
 
 	memory at a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x04000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
index 9c455dc..c85f9d0 100644
--- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
@@ -17,6 +17,7 @@
 	compatible = "eukrea,cpuimx27", "fsl,imx27";
 
 	memory at a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index f9a882d..35123b7 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -10,6 +10,7 @@
 	compatible = "fsl,imx27-pdk", "fsl,imx27";
 
 	memory at a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
index cbad7c8..b0b4f7c 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
@@ -18,6 +18,7 @@
 	compatible = "phytec,imx27-pca100", "fsl,imx27";
 
 	memory at a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x08000000>; /* 128MB */
 	};
 };
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index ec466b4..0935e14 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -17,6 +17,7 @@
 	compatible = "phytec,imx27-pcm038", "fsl,imx27";
 
 	memory at a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 151b0eb..26ff5d4 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
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
