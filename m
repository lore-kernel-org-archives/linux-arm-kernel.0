From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 19 Jan 2017 12:02:46 -0200
Subject: [PATCH v2] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
Message-ID: <1484834566-19845-1-git-send-email-fabio.estevam@nxp.com>
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

Also pass the 'memory' node in order to fix boot issues on the SolidRun
iMX6 platforms.

Fixes: 7f107887d199 ("ARM: dts: imx: Remove skeleton.dtsi")
Reported-by: kernelci.org bot <bot@kernelci.org>
Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Also pass the memory node.

 arch/arm/boot/dts/imx1.dtsi    | 2 ++
 arch/arm/boot/dts/imx23.dtsi   | 2 ++
 arch/arm/boot/dts/imx25.dtsi   | 2 ++
 arch/arm/boot/dts/imx27.dtsi   | 2 ++
 arch/arm/boot/dts/imx28.dtsi   | 2 ++
 arch/arm/boot/dts/imx31.dtsi   | 2 ++
 arch/arm/boot/dts/imx35.dtsi   | 2 ++
 arch/arm/boot/dts/imx50.dtsi   | 2 ++
 arch/arm/boot/dts/imx51.dtsi   | 2 ++
 arch/arm/boot/dts/imx53.dtsi   | 2 ++
 arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
 arch/arm/boot/dts/imx6sl.dtsi  | 2 ++
 arch/arm/boot/dts/imx6sx.dtsi  | 2 ++
 arch/arm/boot/dts/imx6ul.dtsi  | 2 ++
 arch/arm/boot/dts/imx7s.dtsi   | 2 ++
 15 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index dd3de38..7ef0d36 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -18,6 +18,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 96eae64..7bb662c 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -16,6 +16,8 @@
 	#size-cells = <1>;
 
 	interrupt-parent = <&icoll>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		gpio0 = &gpio0;
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 213d86e..f328ecc 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -14,6 +14,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 6a7cb9e..3271ec49 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -19,6 +19,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 905bdb5..5f47558 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -17,6 +17,8 @@
 	#size-cells = <1>;
 
 	interrupt-parent = <&icoll>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &mac0;
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index c0a5d5f..afd4106 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -12,6 +12,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		serial0 = &uart1;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 6f7b943..e08e574 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -13,6 +13,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index fe0221e..46329ff 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -17,6 +17,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 33526ca..c6ffc7b 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -19,6 +19,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index ca51dc0..2d56f26 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -19,6 +19,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 89b834f..c88a373 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -16,6 +16,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 19cbd87..89e8315 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -14,6 +14,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 10f3330..f52d017 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -15,6 +15,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		can0 = &flexcan1;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 0f69a3f..1d93601 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -15,6 +15,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec1;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 8db1eb9..1757789 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -50,6 +50,8 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		gpio0 = &gpio1;
-- 
2.7.4
