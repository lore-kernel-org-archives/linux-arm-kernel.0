From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 10 Nov 2017 19:12:58 -0200
Subject: [PATCH] ARM: dts: imx6: Remove unneeded address-cells/size-cells
Message-ID: <1510348378-18150-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

According to Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt:

"- #address-cells, #size-cells : Must be present if the device has
sub-nodes representing partitions."

Remove the occurrences of #address-cells/size-cells where no sub-nodes
representing partitions are present.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6q-cm-fx6.dts           | 2 --
 arch/arm/boot/dts/imx6q-mccmon6.dts          | 2 --
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi  | 2 --
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi | 2 --
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi     | 2 --
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi       | 2 --
 arch/arm/boot/dts/imx6sl-evk.dts             | 2 --
 arch/arm/boot/dts/imx6sx-sdb-reva.dts        | 4 ----
 arch/arm/boot/dts/imx6sx-sdb.dts             | 4 ----
 9 files changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index bc7587c..5df84e2 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -194,8 +194,6 @@
 	status = "okay";
 
 	m25p80 at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "st,m25p", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6q-mccmon6.dts b/arch/arm/boot/dts/imx6q-mccmon6.dts
index cab36f4..9636e15 100644
--- a/arch/arm/boot/dts/imx6q-mccmon6.dts
+++ b/arch/arm/boot/dts/imx6q-mccmon6.dts
@@ -90,8 +90,6 @@
 	status = "okay";
 
 	s25sl032p: flash at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
 		spi-max-frequency = <40000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
index 7d64075..d8f578c 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
@@ -106,8 +106,6 @@
 	status = "okay";
 
 	flash: m25p80 at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "micron,n25q128a11", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
index 1b18728..5875252 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
@@ -136,8 +136,6 @@
 	status = "okay";
 
 	flash: m25p80 at 1 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "micron,n25q128a11", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <1>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 4fa2fac..828a9a5 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -200,8 +200,6 @@
 	status = "disabled"; /* pin conflict with WEIM NOR */
 
 	flash: m25p80 at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "st,m25p32", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 0a50705..acb0292 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -196,8 +196,6 @@
 	status = "okay";
 
 	flash: m25p80 at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "st,m25p32", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 60600b4..03a2240 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -123,8 +123,6 @@
 	status = "okay";
 
 	flash: m25p80 at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "st,m25p32", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
index e3533e7..ebbed57 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -127,16 +127,12 @@
 
 	flash0: s25fl128s at 0 {
 		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "spansion,s25fl128s", "jedec,spi-nor";
 		spi-max-frequency = <66000000>;
 	};
 
 	flash1: s25fl128s at 1 {
 		reg = <1>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "spansion,s25fl128s", "jedec,spi-nor";
 		spi-max-frequency = <66000000>;
 	};
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 6dd9beb..4b7481a 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -113,16 +113,12 @@
 	status = "okay";
 
 	flash0: n25q256a at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "micron,n25q256a", "jedec,spi-nor";
 		spi-max-frequency = <29000000>;
 		reg = <0>;
 	};
 
 	flash1: n25q256a at 1 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "micron,n25q256a", "jedec,spi-nor";
 		spi-max-frequency = <29000000>;
 		reg = <1>;
-- 
2.7.4
