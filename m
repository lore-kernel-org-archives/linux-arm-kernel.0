From: marcofrk@gmail.com (Marco Franchi)
Date: Wed, 24 Jan 2018 11:22:14 -0200
Subject: [PATCH v3 3/3] ARM: dts: imx: Add memory node unit name
In-Reply-To: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
References: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
Message-ID: <1516800134-5018-3-git-send-email-marcofrk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warnings from dtc by adding the unit name to memory
nodes:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Converted using the following command:

perl -p0777i -e 's/memory \{\n\t\treg = \<0x+([0-9a-f])/memory\@$1$\0000000 \{\n\t\treg = <0x$1/m' `find ./arch/arm/boot/dts -name "imx*"`

The files below were manually fixed:
-imx1-ads.dts
-imx1-apf9328.dts
-imx6q-pistachio.dts

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Change since v2:
-remove script to reg = <0 0> case
 arch/arm/boot/dts/imx1-ads.dts                    | 2 +-
 arch/arm/boot/dts/imx1-apf9328.dts                | 2 +-
 arch/arm/boot/dts/imx23-evk.dts                   | 2 +-
 arch/arm/boot/dts/imx23-olinuxino.dts             | 2 +-
 arch/arm/boot/dts/imx23-sansa.dts                 | 2 +-
 arch/arm/boot/dts/imx23-stmp378x_devb.dts         | 2 +-
 arch/arm/boot/dts/imx23-xfi3.dts                  | 2 +-
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi      | 2 +-
 arch/arm/boot/dts/imx25-karo-tx25.dts             | 2 +-
 arch/arm/boot/dts/imx25-pdk.dts                   | 2 +-
 arch/arm/boot/dts/imx27-apf27.dts                 | 2 +-
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi      | 2 +-
 arch/arm/boot/dts/imx27-pdk.dts                   | 2 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi | 2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi   | 2 +-
 arch/arm/boot/dts/imx28-apf28.dts                 | 2 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts            | 2 +-
 arch/arm/boot/dts/imx28-cfa10036.dts              | 2 +-
 arch/arm/boot/dts/imx28-duckbill-2-485.dts        | 2 +-
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts    | 2 +-
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts        | 2 +-
 arch/arm/boot/dts/imx28-duckbill-2.dts            | 2 +-
 arch/arm/boot/dts/imx28-duckbill.dts              | 2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts      | 2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts      | 2 +-
 arch/arm/boot/dts/imx28-evk.dts                   | 2 +-
 arch/arm/boot/dts/imx28-m28.dtsi                  | 2 +-
 arch/arm/boot/dts/imx28-m28cu3.dts                | 2 +-
 arch/arm/boot/dts/imx28-sps1.dts                  | 2 +-
 arch/arm/boot/dts/imx28-ts4600.dts                | 2 +-
 arch/arm/boot/dts/imx31-bug.dts                   | 2 +-
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi      | 2 +-
 arch/arm/boot/dts/imx35-pdk.dts                   | 2 +-
 arch/arm/boot/dts/imx50-evk.dts                   | 2 +-
 arch/arm/boot/dts/imx51-apf51.dts                 | 2 +-
 arch/arm/boot/dts/imx51-babbage.dts               | 2 +-
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi | 2 +-
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi      | 2 +-
 arch/arm/boot/dts/imx51-ts4800.dts                | 2 +-
 arch/arm/boot/dts/imx53-ard.dts                   | 2 +-
 arch/arm/boot/dts/imx53-cx9020.dts                | 2 +-
 arch/arm/boot/dts/imx53-m53.dtsi                  | 2 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi           | 2 +-
 arch/arm/boot/dts/imx53-smd.dts                   | 2 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi               | 2 +-
 arch/arm/boot/dts/imx53-usbarmory.dts             | 2 +-
 arch/arm/boot/dts/imx6dl-apf6dev.dts              | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts      | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts      | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts       | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts       | 2 +-
 arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi       | 2 +-
 arch/arm/boot/dts/imx6dl-rex-basic.dts            | 2 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts            | 2 +-
 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts      | 2 +-
 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts      | 2 +-
 arch/arm/boot/dts/imx6dl-wandboard.dts            | 2 +-
 arch/arm/boot/dts/imx6q-apf6dev.dts               | 2 +-
 arch/arm/boot/dts/imx6q-arm2.dts                  | 2 +-
 arch/arm/boot/dts/imx6q-ba16.dtsi                 | 2 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                | 2 +-
 arch/arm/boot/dts/imx6q-display5.dtsi             | 2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts           | 2 +-
 arch/arm/boot/dts/imx6q-evi.dts                   | 2 +-
 arch/arm/boot/dts/imx6q-gk802.dts                 | 2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts              | 2 +-
 arch/arm/boot/dts/imx6q-marsboard.dts             | 2 +-
 arch/arm/boot/dts/imx6q-mccmon6.dts               | 2 +-
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi        | 2 +-
 arch/arm/boot/dts/imx6q-pistachio.dts             | 2 +-
 arch/arm/boot/dts/imx6q-rex-pro.dts               | 2 +-
 arch/arm/boot/dts/imx6q-sbc6x.dts                 | 2 +-
 arch/arm/boot/dts/imx6q-tbs2910.dts               | 2 +-
 arch/arm/boot/dts/imx6q-wandboard-revb1.dts       | 2 +-
 arch/arm/boot/dts/imx6q-wandboard-revd1.dts       | 2 +-
 arch/arm/boot/dts/imx6q-wandboard.dts             | 2 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi             | 2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi             | 2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi             | 2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi             | 2 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi             | 2 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi             | 2 +-
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi             | 2 +-
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi             | 2 +-
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi             | 2 +-
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi          | 2 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi              | 2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi          | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi      | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi         | 2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi      | 2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi          | 2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi          | 2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi            | 2 +-
 arch/arm/boot/dts/imx6qdl-udoo.dtsi               | 2 +-
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi           | 2 +-
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts      | 2 +-
 arch/arm/boot/dts/imx6sl-evk.dts                  | 2 +-
 arch/arm/boot/dts/imx6sl-warp.dts                 | 2 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts          | 2 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts            | 2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                 | 2 +-
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts  | 2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts       | 2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts    | 2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts        | 2 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts            | 2 +-
 arch/arm/boot/dts/imx6ul-geam.dts                 | 2 +-
 arch/arm/boot/dts/imx6ul-isiot.dtsi               | 2 +-
 arch/arm/boot/dts/imx6ul-litesom.dtsi             | 2 +-
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi             | 2 +-
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts          | 2 +-
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts           | 2 +-
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi         | 2 +-
 arch/arm/boot/dts/imx7d-colibri.dtsi              | 2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts             | 2 +-
 arch/arm/boot/dts/imx7d-pico.dtsi                 | 2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                   | 2 +-
 arch/arm/boot/dts/imx7s-colibri.dtsi              | 2 +-
 arch/arm/boot/dts/imx7s-warp.dts                  | 2 +-
 121 files changed, 121 insertions(+), 121 deletions(-)

diff --git a/arch/arm/boot/dts/imx1-ads.dts b/arch/arm/boot/dts/imx1-ads.dts
index 5ea28ee..6354e4c 100644
--- a/arch/arm/boot/dts/imx1-ads.dts
+++ b/arch/arm/boot/dts/imx1-ads.dts
@@ -20,7 +20,7 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 8000000 {
 		reg = <0x08000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx1-apf9328.dts b/arch/arm/boot/dts/imx1-apf9328.dts
index e8b4b52c..11515c0 100644
--- a/arch/arm/boot/dts/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/imx1-apf9328.dts
@@ -20,7 +20,7 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 8000000 {
 		reg = <0x08000000 0x00800000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 57e2997..9d92ece82 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -16,7 +16,7 @@
 	model = "Freescale i.MX23 Evaluation Kit";
 	compatible = "fsl,imx23-evk", "fsl,imx23";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index a8b1c53..e935177 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -19,7 +19,7 @@
 	model = "i.MX23 Olinuxino Low Cost Board";
 	compatible = "olimex,imx23-olinuxino", "fsl,imx23";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx23-sansa.dts b/arch/arm/boot/dts/imx23-sansa.dts
index 221fd55..67de786 100644
--- a/arch/arm/boot/dts/imx23-sansa.dts
+++ b/arch/arm/boot/dts/imx23-sansa.dts
@@ -49,7 +49,7 @@
 	model = "SanDisk Sansa Fuze+";
 	compatible = "sandisk,sansa_fuze_plus", "fsl,imx23";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx23-stmp378x_devb.dts b/arch/arm/boot/dts/imx23-stmp378x_devb.dts
index 455169e..95c7b91 100644
--- a/arch/arm/boot/dts/imx23-stmp378x_devb.dts
+++ b/arch/arm/boot/dts/imx23-stmp378x_devb.dts
@@ -16,7 +16,7 @@
 	model = "Freescale STMP378x Development Board";
 	compatible = "fsl,stmp378x-devb", "fsl,imx23";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx23-xfi3.dts b/arch/arm/boot/dts/imx23-xfi3.dts
index 025cf94..9616e50 100644
--- a/arch/arm/boot/dts/imx23-xfi3.dts
+++ b/arch/arm/boot/dts/imx23-xfi3.dts
@@ -48,7 +48,7 @@
 	model = "Creative ZEN X-Fi3";
 	compatible = "creative,x-fi3", "fsl,imx23";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
index d6f2764..e316fe0 100644
--- a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
+++ b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
@@ -17,7 +17,7 @@
 	model = "Eukrea CPUIMX25";
 	compatible = "eukrea,cpuimx25", "fsl,imx25";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x4000000>; /* 64M */
 	};
 };
diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
index 30a62d4..5cb6967 100644
--- a/arch/arm/boot/dts/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
@@ -36,7 +36,7 @@
 		};
 	};
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x02000000 0x90000000 0x02000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 2d15ce7..c7ef3ff 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -18,7 +18,7 @@
 	model = "Freescale i.MX25 Product Development Kit";
 	compatible = "fsl,imx25-pdk", "fsl,imx25";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index 73aae4f..66941cd 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -19,7 +19,7 @@
 	model = "Armadeus Systems APF27 module";
 	compatible = "armadeus,imx27-apf27", "fsl,imx27";
 
-	memory {
+	memory at a0000000 {
 		reg = <0xa0000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
index 2cf896c..b2b6f84 100644
--- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
@@ -16,7 +16,7 @@
 	model = "Eukrea CPUIMX27";
 	compatible = "eukrea,cpuimx27", "fsl,imx27";
 
-	memory {
+	memory at a0000000 {
 		reg = <0xa0000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 2a140c8..924b90c 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -16,7 +16,7 @@
 	model = "Freescale i.MX27 Product Development Kit";
 	compatible = "fsl,imx27-pdk", "fsl,imx27";
 
-	memory {
+	memory at a0000000 {
 		reg = <0xa0000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
index 0b8490b..cbad7c8 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
@@ -17,7 +17,7 @@
 	model = "Phytec pca100";
 	compatible = "phytec,imx27-pca100", "fsl,imx27";
 
-	memory {
+	memory at a0000000 {
 		reg = <0xa0000000 0x08000000>; /* 128MB */
 	};
 };
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index c9095b7..ec466b4 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -16,7 +16,7 @@
 	model = "Phytec pcm038";
 	compatible = "phytec,imx27-pcm038", "fsl,imx27";
 
-	memory {
+	memory at a0000000 {
 		reg = <0xa0000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-apf28.dts b/arch/arm/boot/dts/imx28-apf28.dts
index 070e59c..bab7834 100644
--- a/arch/arm/boot/dts/imx28-apf28.dts
+++ b/arch/arm/boot/dts/imx28-apf28.dts
@@ -16,7 +16,7 @@
 	model = "Armadeus Systems APF28 module";
 	compatible = "armadeus,imx28-apf28", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index ae07834..e782494 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -6,7 +6,7 @@
 	model = "Bluegiga APX4 Development Kit";
 	compatible = "bluegiga,apx4devkit", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index 570aa33..e54f5ab 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -16,7 +16,7 @@
 	model = "Crystalfontz CFA-10036 Board";
 	compatible = "crystalfontz,cfa10036", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-485.dts b/arch/arm/boot/dts/imx28-duckbill-2-485.dts
index bd3fd47..97084e4 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2-485.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2-485.dts
@@ -19,7 +19,7 @@
 	model = "I2SE Duckbill 2 485";
 	compatible = "i2se,duckbill-2-485", "i2se,duckbill-2", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
index 4450047..7f8d40a 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
@@ -20,7 +20,7 @@
 	model = "I2SE Duckbill 2 EnOcean";
 	compatible = "i2se,duckbill-2-enocean", "i2se,duckbill-2", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-spi.dts b/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
index 927732e..13e7b13 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
@@ -23,7 +23,7 @@
 		ethernet1 = &qca7000;
 	};
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-duckbill-2.dts b/arch/arm/boot/dts/imx28-duckbill-2.dts
index 7fa3d75..88556c9 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2.dts
@@ -19,7 +19,7 @@
 	model = "I2SE Duckbill 2";
 	compatible = "i2se,duckbill-2", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
index 3e4385d..f286bfe 100644
--- a/arch/arm/boot/dts/imx28-duckbill.dts
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -18,7 +18,7 @@
 	model = "I2SE Duckbill";
 	compatible = "i2se,duckbill", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts b/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
index 7c1572c..b70f334 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
@@ -23,7 +23,7 @@
 	model = "Eukrea Electromatique MBMX283LC";
 	compatible = "eukrea,mbmx283lc", "eukrea,mbmx28lc", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x04000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts b/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
index b61fd61..65efb78 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
@@ -22,7 +22,7 @@
 	model = "Eukrea Electromatique MBMX287LC";
 	compatible = "eukrea,mbmx287lc", "eukrea,mbmx283lc", "eukrea,mbmx28lc", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 7f5b804..8ccbcc1 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -16,7 +16,7 @@
 	model = "Freescale i.MX28 Evaluation Kit";
 	compatible = "fsl,imx28-evk", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
index a69856e..0ec415e 100644
--- a/arch/arm/boot/dts/imx28-m28.dtsi
+++ b/arch/arm/boot/dts/imx28-m28.dtsi
@@ -15,7 +15,7 @@
 	model = "Aries/DENX M28";
 	compatible = "aries,m28", "denx,m28", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index 9d6c8fe..3bb5ffc 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -16,7 +16,7 @@
 	model = "MSR M28CU3";
 	compatible = "msr,m28cu3", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
index 0ce3cb8..2393e839 100644
--- a/arch/arm/boot/dts/imx28-sps1.dts
+++ b/arch/arm/boot/dts/imx28-sps1.dts
@@ -16,7 +16,7 @@
 	model = "SchulerControl GmbH, SC SPS 1";
 	compatible = "schulercontrol,imx28-sps1", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-ts4600.dts b/arch/arm/boot/dts/imx28-ts4600.dts
index 1e391c9..f8a09a8 100644
--- a/arch/arm/boot/dts/imx28-ts4600.dts
+++ b/arch/arm/boot/dts/imx28-ts4600.dts
@@ -19,7 +19,7 @@
 	model = "Technologic Systems i.MX28 TS-4600";
 	compatible = "technologic,imx28-ts4600", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x10000000>;   /* 256MB */
 	};
 
diff --git a/arch/arm/boot/dts/imx31-bug.dts b/arch/arm/boot/dts/imx31-bug.dts
index ae6cebb..6ee4ff8 100644
--- a/arch/arm/boot/dts/imx31-bug.dts
+++ b/arch/arm/boot/dts/imx31-bug.dts
@@ -16,7 +16,7 @@
 	model = "Buglabs i.MX31 Bug 1.x";
 	compatible = "buglabs,imx31-bug", "fsl,imx31";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x8000000>; /* 128M */
 	};
 };
diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
index 9c2b715..ba39d93 100644
--- a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
+++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
@@ -17,7 +17,7 @@
 	model = "Eukrea CPUIMX35";
 	compatible = "eukrea,cpuimx35", "fsl,imx35";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x8000000>; /* 128M */
 	};
 };
diff --git a/arch/arm/boot/dts/imx35-pdk.dts b/arch/arm/boot/dts/imx35-pdk.dts
index 9bb628f..646b125 100644
--- a/arch/arm/boot/dts/imx35-pdk.dts
+++ b/arch/arm/boot/dts/imx35-pdk.dts
@@ -17,7 +17,7 @@
 	model = "Freescale i.MX35 Product Development Kit";
 	compatible = "fsl,imx35-pdk", "fsl,imx35";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x8000000>,
 		      <0x90000000 0x8000000>;
 	};
diff --git a/arch/arm/boot/dts/imx50-evk.dts b/arch/arm/boot/dts/imx50-evk.dts
index 98b5faa..23f1833 100644
--- a/arch/arm/boot/dts/imx50-evk.dts
+++ b/arch/arm/boot/dts/imx50-evk.dts
@@ -18,7 +18,7 @@
 	model = "Freescale i.MX50 Evaluation Kit";
 	compatible = "fsl,imx50-evk", "fsl,imx50";
 
-	memory {
+	memory at 70000000 {
 		reg = <0x70000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx51-apf51.dts b/arch/arm/boot/dts/imx51-apf51.dts
index c83ac16..79d8003 100644
--- a/arch/arm/boot/dts/imx51-apf51.dts
+++ b/arch/arm/boot/dts/imx51-apf51.dts
@@ -21,7 +21,7 @@
 	model = "Armadeus Systems APF51 module";
 	compatible = "armadeus,imx51-apf51", "fsl,imx51";
 
-	memory {
+	memory at 90000000 {
 		reg = <0x90000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 4ac5ab6..51b1211 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -21,7 +21,7 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 90000000 {
 		reg = <0x90000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
index b821066..5761a66 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
@@ -16,7 +16,7 @@
 	model = "Digi ConnectCore CC(W)-MX51";
 	compatible = "digi,connectcore-ccxmx51-som", "fsl,imx51";
 
-	memory {
+	memory at 90000000 {
 		reg = <0x90000000 0x08000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
index 6316426..f8902a3 100644
--- a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
+++ b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
@@ -22,7 +22,7 @@
 	model = "Eukrea CPUIMX51";
 	compatible = "eukrea,cpuimx51", "fsl,imx51";
 
-	memory {
+	memory at 90000000 {
 		reg = <0x90000000 0x10000000>; /* 256M */
 	};
 };
diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index f59b02b..39eb067 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -17,7 +17,7 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 90000000 {
 		reg = <0x90000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 4486bc4..80fc007 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -17,7 +17,7 @@
 	model = "Freescale i.MX53 Automotive Reference Design Board";
 	compatible = "fsl,imx53-ard", "fsl,imx53";
 
-	memory {
+	memory at 70000000 {
 		reg = <0x70000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx53-cx9020.dts b/arch/arm/boot/dts/imx53-cx9020.dts
index 5e67e43..cf70ebc 100644
--- a/arch/arm/boot/dts/imx53-cx9020.dts
+++ b/arch/arm/boot/dts/imx53-cx9020.dts
@@ -21,7 +21,7 @@
 		stdout-path = &uart2;
 	};
 
-	memory {
+	memory at 70000000 {
 		reg = <0x70000000 0x20000000>,
 		      <0xb0000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/imx53-m53.dtsi b/arch/arm/boot/dts/imx53-m53.dtsi
index 7ce69c6..3da6dd5 100644
--- a/arch/arm/boot/dts/imx53-m53.dtsi
+++ b/arch/arm/boot/dts/imx53-m53.dtsi
@@ -15,7 +15,7 @@
 	model = "Aries/DENX M53";
 	compatible = "aries,imx53-m53", "denx,imx53-m53", "fsl,imx53";
 
-	memory {
+	memory at 70000000 {
 		reg = <0x70000000 0x20000000>,
 		      <0xb0000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index 41a2e2a..08ac46e 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -17,7 +17,7 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 70000000 {
 		reg = <0x70000000 0x20000000>,
 		      <0xb0000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 51f4a42..fd03012 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -17,7 +17,7 @@
 	model = "Freescale i.MX53 Smart Mobile Reference Design Board";
 	compatible = "fsl,imx53-smd", "fsl,imx53";
 
-	memory {
+	memory at 70000000 {
 		reg = <0x70000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index eecdc1c..a72b898 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -16,7 +16,7 @@
 	model = "TQ TQMa53";
 	compatible = "tq,tqma53", "fsl,imx53";
 
-	memory {
+	memory at 70000000 {
 		reg = <0x70000000 0x40000000>; /* Up to 1GiB */
 	};
 
diff --git a/arch/arm/boot/dts/imx53-usbarmory.dts b/arch/arm/boot/dts/imx53-usbarmory.dts
index 6782d7f..f6268d0 100644
--- a/arch/arm/boot/dts/imx53-usbarmory.dts
+++ b/arch/arm/boot/dts/imx53-usbarmory.dts
@@ -57,7 +57,7 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 70000000 {
 		reg = <0x70000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-apf6dev.dts b/arch/arm/boot/dts/imx6dl-apf6dev.dts
index df26e54..4a7f86d 100644
--- a/arch/arm/boot/dts/imx6dl-apf6dev.dts
+++ b/arch/arm/boot/dts/imx6dl-apf6dev.dts
@@ -54,7 +54,7 @@
 	model = "Armadeus APF6 Solo Module on APF6Dev Board";
 	compatible = "armadeus,imx6dl-apf6dev", "armadeus,imx6dl-apf6", "fsl,imx6dl";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
index 5f0d196..7128c76 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
@@ -48,7 +48,7 @@
 	model = "aristainetos2 i.MX6 Dual Lite Board 4";
 	compatible = "fsl,imx6dl";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
index 805b131..240f366 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
@@ -48,7 +48,7 @@
 	model = "aristainetos2 i.MX6 Dual Lite Board 7";
 	compatible = "fsl,imx6dl";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
index 3c9f4af..ad77336 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
@@ -27,7 +27,7 @@
 		status = "okay";
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
index 96cd835..64ed84e 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
@@ -16,7 +16,7 @@
 	model = "aristainetos i.MX6 Dual Lite Board 7";
 	compatible = "fsl,imx6dl";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi
index 964bc2a..7d98889 100644
--- a/arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi
@@ -16,7 +16,7 @@
 	model = "Phytec phyFLEX-i.MX6 DualLite/Solo";
 	compatible = "phytec,imx6dl-pfla02", "fsl,imx6dl";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-rex-basic.dts b/arch/arm/boot/dts/imx6dl-rex-basic.dts
index c3a14a4..3fb7f4e 100644
--- a/arch/arm/boot/dts/imx6dl-rex-basic.dts
+++ b/arch/arm/boot/dts/imx6dl-rex-basic.dts
@@ -16,7 +16,7 @@
 	model = "Rex Basic i.MX6 Dual Lite Board";
 	compatible = "rex,imx6dl-rex-basic", "fsl,imx6dl";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 23e1082..2e98c92 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -15,7 +15,7 @@
 	model = "RIoTboard i.MX6S";
 	compatible = "riot,imx6s-riotboard", "fsl,imx6dl";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts b/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts
index 8c314ee..5727fa4 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts
@@ -16,7 +16,7 @@
 	model = "Wandboard i.MX6 Dual Lite Board rev B1";
 	compatible = "wand,imx6dl-wandboard", "fsl,imx6dl";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts b/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
index aa4d4fa..a72c07d 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
@@ -16,7 +16,7 @@
 	model = "Wandboard i.MX6 Dual Lite Board revD1";
 	compatible = "wand,imx6dl-wandboard", "fsl,imx6dl";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dts b/arch/arm/boot/dts/imx6dl-wandboard.dts
index bbb6167..a09f274 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard.dts
@@ -16,7 +16,7 @@
 	model = "Wandboard i.MX6 Dual Lite Board";
 	compatible = "wand,imx6dl-wandboard", "fsl,imx6dl";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-apf6dev.dts b/arch/arm/boot/dts/imx6q-apf6dev.dts
index 4e4de82..5e72f81 100644
--- a/arch/arm/boot/dts/imx6q-apf6dev.dts
+++ b/arch/arm/boot/dts/imx6q-apf6dev.dts
@@ -54,7 +54,7 @@
 	model = "Armadeus APF6 Quad / Dual Module on APF6Dev Board";
 	compatible = "armadeus,imx6q-apf6dev", "armadeus,imx6q-apf6", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index 4989d0b..953a5b5 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -18,7 +18,7 @@
 	model = "Freescale i.MX6 Quad Armadillo2 Board";
 	compatible = "fsl,imx6q-arm2", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index 5fcb037..bf4bdb3 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -46,7 +46,7 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index bc7587c..65ef4ca 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -50,7 +50,7 @@
 	model = "CompuLab CM-FX6";
 	compatible = "compulab,cm-fx6", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-display5.dtsi b/arch/arm/boot/dts/imx6q-display5.dtsi
index 09085fd..85232c7 100644
--- a/arch/arm/boot/dts/imx6q-display5.dtsi
+++ b/arch/arm/boot/dts/imx6q-display5.dtsi
@@ -47,7 +47,7 @@
 	model = "Liebherr (LWN) display5 i.MX6 Quad Board";
 	compatible = "lwn,display5", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index f0316ea..b3c6a4a 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -29,7 +29,7 @@
 		stmpe-i2c1 = &stmpe2;
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index e0aea78..fcd257b 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -50,7 +50,7 @@
 	model = "Uniwest Evi";
 	compatible = "uniwest,imx6q-evi", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-gk802.dts b/arch/arm/boot/dts/imx6q-gk802.dts
index b715deb..0be3756 100644
--- a/arch/arm/boot/dts/imx6q-gk802.dts
+++ b/arch/arm/boot/dts/imx6q-gk802.dts
@@ -18,7 +18,7 @@
 		stdout-path = &uart4;
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 29adaa7c..a8f70b4 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -60,7 +60,7 @@
 		};
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-marsboard.dts b/arch/arm/boot/dts/imx6q-marsboard.dts
index 432291b..dd763f2 100644
--- a/arch/arm/boot/dts/imx6q-marsboard.dts
+++ b/arch/arm/boot/dts/imx6q-marsboard.dts
@@ -47,7 +47,7 @@
 	model = "Embest MarS Board i.MX6Dual";
 	compatible = "embest,imx6q-marsboard", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-mccmon6.dts b/arch/arm/boot/dts/imx6q-mccmon6.dts
index cab36f4..b7e9f38 100644
--- a/arch/arm/boot/dts/imx6q-mccmon6.dts
+++ b/arch/arm/boot/dts/imx6q-mccmon6.dts
@@ -19,7 +19,7 @@
 	model = "Liebherr (LWN) monitor6 i.MX6 Quad Board";
 	compatible = "lwn,mccmon6", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
index cd20d0a..fad858c 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -16,7 +16,7 @@
 	model = "Phytec phyFLEX-i.MX6 Quad";
 	compatible = "phytec,imx6q-pfla02", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-pistachio.dts b/arch/arm/boot/dts/imx6q-pistachio.dts
index 1effb58..bd57b3b 100644
--- a/arch/arm/boot/dts/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/imx6q-pistachio.dts
@@ -56,7 +56,7 @@
 		stdout-path = &uart4;
 	};
 
-	memory: memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-rex-pro.dts b/arch/arm/boot/dts/imx6q-rex-pro.dts
index 90ea61a..d6cae73 100644
--- a/arch/arm/boot/dts/imx6q-rex-pro.dts
+++ b/arch/arm/boot/dts/imx6q-rex-pro.dts
@@ -16,7 +16,7 @@
 	model = "Rex Pro i.MX6 Quad Board";
 	compatible = "rex,imx6q-rex-pro", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-sbc6x.dts b/arch/arm/boot/dts/imx6q-sbc6x.dts
index 2557330..b7aa2f0 100644
--- a/arch/arm/boot/dts/imx6q-sbc6x.dts
+++ b/arch/arm/boot/dts/imx6q-sbc6x.dts
@@ -12,7 +12,7 @@
 	model = "MicroSys sbc6x board";
 	compatible = "microsys,sbc6x", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index a3cd7af..505cba7 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -59,7 +59,7 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-wandboard-revb1.dts b/arch/arm/boot/dts/imx6q-wandboard-revb1.dts
index 9207d80..b763352 100644
--- a/arch/arm/boot/dts/imx6q-wandboard-revb1.dts
+++ b/arch/arm/boot/dts/imx6q-wandboard-revb1.dts
@@ -16,7 +16,7 @@
 	model = "Wandboard i.MX6 Quad Board rev B1";
 	compatible = "wand,imx6q-wandboard", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-wandboard-revd1.dts b/arch/arm/boot/dts/imx6q-wandboard-revd1.dts
index e87ddb1..8691fab 100644
--- a/arch/arm/boot/dts/imx6q-wandboard-revd1.dts
+++ b/arch/arm/boot/dts/imx6q-wandboard-revd1.dts
@@ -16,7 +16,7 @@
 	model = "Wandboard i.MX6 Quad Board revD1";
 	compatible = "wand,imx6q-wandboard", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-wandboard.dts b/arch/arm/boot/dts/imx6q-wandboard.dts
index 4a8a6ee..2a3d98c 100644
--- a/arch/arm/boot/dts/imx6q-wandboard.dts
+++ b/arch/arm/boot/dts/imx6q-wandboard.dts
@@ -16,7 +16,7 @@
 	model = "Wandboard i.MX6 Quad Board";
 	compatible = "wand,imx6q-wandboard", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index dea8fc4..17a7b9c 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -44,7 +44,7 @@
 		};
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 363a443..b804468 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -59,7 +59,7 @@
 		};
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index c75385c..629908f 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -59,7 +59,7 @@
 		};
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index eab75f3..a1a6fb5 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -59,7 +59,7 @@
 		};
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 30d4662..4e21b38 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -74,7 +74,7 @@
 		};
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index c67c106..81dae5b 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -51,7 +51,7 @@
 		};
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
index 1a0faa1..c5d95e8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
@@ -80,7 +80,7 @@
 		};
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index 4444251..3681322 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -83,7 +83,7 @@
 		};
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
index fd4b68b..58124ad 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -93,7 +93,7 @@
 		};
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index b6220d6..49daa2b 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -44,7 +44,7 @@
 #include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index a1b469c..b3a463a 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -45,7 +45,7 @@
 #include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index 4cc4e23..aab088f 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -46,7 +46,7 @@
 		stdout-path = &uart2;
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index fd05f7c..87ca6ea 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -46,7 +46,7 @@
 		stdout-path = &uart2;
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0xF0000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
index 40942d6..f5b763d 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
@@ -46,7 +46,7 @@
 		stdout-path = &uart2;
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 919b6b7..596866b 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -48,7 +48,7 @@
 		stdout-path = &uart2;
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index d81b007..c58f344 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -15,7 +15,7 @@
 	model = "Phytec phyFLEX-i.MX6 Quad";
 	compatible = "phytec,imx6q-pfla02", "fsl,imx6q";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 82d6ccb..54b0139 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -13,7 +13,7 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 35de7ad..18b6505 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -49,7 +49,7 @@
 		stdout-path = &uart2;
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 0a50705..f019f99 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -19,7 +19,7 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 4161b7d..9063879 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -35,7 +35,7 @@
 		pinctrl-names = "default";
 	};
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-var-dart.dtsi b/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
index 421d6f5..38080c1 100644
--- a/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
@@ -10,7 +10,7 @@
 #include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts b/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
index f7badd8..907ba0c 100644
--- a/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
+++ b/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
@@ -16,7 +16,7 @@
 	model = "Wandboard i.MX6 QuadPlus Board revD1";
 	compatible = "wand,imx6qp-wandboard", "fsl,imx6qp";
 
-	memory {
+	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 2844ab5..37e792f 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -16,7 +16,7 @@
 	model = "Freescale i.MX6 SoloLite EVK Board";
 	compatible = "fsl,imx6sl-evk", "fsl,imx6sl";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/imx6sl-warp.dts
index 72c7745..404e602 100644
--- a/arch/arm/boot/dts/imx6sl-warp.dts
+++ b/arch/arm/boot/dts/imx6sl-warp.dts
@@ -54,7 +54,7 @@
 	model = "WaRP Board";
 	compatible = "warp,imx6sl-warp", "fsl,imx6sl";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
index f9d40ee..b58f770 100644
--- a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
+++ b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
@@ -52,7 +52,7 @@
 		t_lcd = &t_lcd;
 	};
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 240a286..72da5ac 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -14,7 +14,7 @@
 	model = "Freescale i.MX6 SoloX Sabre Auto Board";
 	compatible = "fsl,imx6sx-sabreauto", "fsl,imx6sx";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index d35aa85..f8f3187 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -20,7 +20,7 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
index 4d8c652..252175b 100644
--- a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
+++ b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
@@ -20,7 +20,7 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts b/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
index 0c1fc1a..40ccdf4 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
@@ -48,7 +48,7 @@
 	model = "UDOO Neo Basic";
 	compatible = "udoo,neobasic", "fsl,imx6sx";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts b/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
index 5d6c227..42bfc8f 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
@@ -48,7 +48,7 @@
 	model = "UDOO Neo Extended";
 	compatible = "udoo,neoextended", "fsl,imx6sx";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts b/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
index 653ceb2..c84c877 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
@@ -48,7 +48,7 @@
 	model = "UDOO Neo Full";
 	compatible = "udoo,neofull", "fsl,imx6sx";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 18fdb08..3456596 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -18,7 +18,7 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6ul-geam.dts b/arch/arm/boot/dts/imx6ul-geam.dts
index 571eea7..0dbbd78 100644
--- a/arch/arm/boot/dts/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/imx6ul-geam.dts
@@ -50,7 +50,7 @@
 	model = "Engicam GEAM6UL Starter Kit";
 	compatible = "engicam,imx6ul-geam", "fsl,imx6ul";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index 950fb28..b0ecebb 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -45,7 +45,7 @@
 #include "imx6ul.dtsi"
 
 / {
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6ul-litesom.dtsi b/arch/arm/boot/dts/imx6ul-litesom.dtsi
index 039721d..8f775f6 100644
--- a/arch/arm/boot/dts/imx6ul-litesom.dtsi
+++ b/arch/arm/boot/dts/imx6ul-litesom.dtsi
@@ -47,7 +47,7 @@
 	model = "Grinn i.MX6UL liteSOM";
 	compatible = "grinn,imx6ul-litesom", "fsl,imx6ul";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6ul-opos6ul.dtsi b/arch/arm/boot/dts/imx6ul-opos6ul.dtsi
index aec5ccc..a031bee 100644
--- a/arch/arm/boot/dts/imx6ul-opos6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-opos6ul.dtsi
@@ -48,7 +48,7 @@
 #include "imx6ul.dtsi"
 
 / {
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0>; /* will be filled by U-Boot */
 	};
 
diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
index 3bf26eb..47682b8 100644
--- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
@@ -51,7 +51,7 @@
 	model = "Technexion Pico i.MX6UL Board";
 	compatible = "technexion,imx6ul-pico-hobbit", "fsl,imx6ul";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index ae45af1..c1a3d62 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -18,7 +18,7 @@
 	model = "CompuLab CL-SOM-iMX7";
 	compatible = "compulab,cl-som-imx7", "fsl,imx7d";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x10000000>; /* 256 MB - minimal configuration */
 	};
 
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
index 9b63b9c..04d24ee 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -7,7 +7,7 @@
 #include "imx7-colibri.dtsi"
 
 / {
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/imx7d-colibri.dtsi
index 6f2bb70..d9f8fb6 100644
--- a/arch/arm/boot/dts/imx7d-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri.dtsi
@@ -44,7 +44,7 @@
 #include "imx7-colibri.dtsi"
 
 / {
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 2b05898..52167298 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -53,7 +53,7 @@
 		t_lcd = &t_lcd;
 	};
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index e307462..21973eb 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -48,7 +48,7 @@
 	model = "Technexion Pico i.MX7D Board";
 	compatible = "technexion,imx7d-pico", "fsl,imx7d";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index a7a5dc7..7535c1c 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -48,7 +48,7 @@
 	model = "Freescale i.MX7 SabreSD Board";
 	compatible = "fsl,imx7d-sdb", "fsl,imx7d";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx7s-colibri.dtsi b/arch/arm/boot/dts/imx7s-colibri.dtsi
index b810134..fe8344c 100644
--- a/arch/arm/boot/dts/imx7s-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7s-colibri.dtsi
@@ -44,7 +44,7 @@
 #include "imx7-colibri.dtsi"
 
 / {
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x10000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 9bdf121..fc6e6bb 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -50,7 +50,7 @@
 	model = "Warp i.MX7 Board";
 	compatible = "warp,imx7s-warp", "fsl,imx7s";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
-- 
2.7.4
