From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Mon, 19 Dec 2016 13:28:18 -0200
Subject: [PATCH] ARM: dts: imx: Pass an empty 'chosen' node
Message-ID: <1482161298-32624-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7f107887d199 ("ARM: dts: imx: Remove skeleton.dtsi") causes boot
issues when the bootloader does not create a 'chosen' node if such node
is not present in the dtb.

The reason for the boot failure is well explained by Javier Martinez
Canillas: "the decompressor relies on a pre-existing chosen node to be
available to insert the command line and merge other ATAGS info."

, so pass an empty 'chosen' node to fix the boot problem.

This issue has been seen in the kernelci reports with Barebox as
bootloader.

Fixes: 7f107887d199 ("ARM: dts: imx: Remove skeleton.dtsi")
Reported-by: kernelci.org bot <bot@kernelci.org>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx1.dtsi    | 1 +
 arch/arm/boot/dts/imx23.dtsi   | 1 +
 arch/arm/boot/dts/imx25.dtsi   | 1 +
 arch/arm/boot/dts/imx27.dtsi   | 1 +
 arch/arm/boot/dts/imx28.dtsi   | 1 +
 arch/arm/boot/dts/imx31.dtsi   | 1 +
 arch/arm/boot/dts/imx35.dtsi   | 1 +
 arch/arm/boot/dts/imx50.dtsi   | 1 +
 arch/arm/boot/dts/imx51.dtsi   | 1 +
 arch/arm/boot/dts/imx53.dtsi   | 1 +
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 arch/arm/boot/dts/imx6sl.dtsi  | 1 +
 arch/arm/boot/dts/imx6sx.dtsi  | 1 +
 arch/arm/boot/dts/imx6ul.dtsi  | 1 +
 arch/arm/boot/dts/imx7s.dtsi   | 1 +
 15 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index b792eee..a9581b5 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -18,6 +18,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index ac2a9da..d00bc55 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -14,6 +14,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	interrupt-parent = <&icoll>;
 
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 831d09a..a0348b0 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -14,6 +14,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 9d8b596..84652eb 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -19,6 +19,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 3aabf65..6635213 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -15,6 +15,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	interrupt-parent = <&icoll>;
 
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 685916e..8a1ea22 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -12,6 +12,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		serial0 = &uart1;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 9f40e62..4c67438 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -13,6 +13,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index fe0221e..6e947bd 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -17,6 +17,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 33526ca..d1f8b93 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -19,6 +19,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index ca51dc0..ea308b0 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -19,6 +19,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 53e6e63..c9efd45 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -16,6 +16,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 4fd6de2..4cd16f2 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -14,6 +14,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 076a30f..9bb1563 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -15,6 +15,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		can0 = &flexcan1;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 39845a7..a910fa3 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -15,6 +15,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		ethernet0 = &fec1;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 8ff2cbdd..6408b9d 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -50,6 +50,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
 
 	aliases {
 		gpio0 = &gpio1;
-- 
1.9.1
