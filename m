From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Jan 2017 14:54:10 -0200
Subject: [PATCH v3] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
Message-ID: <1485190450-29153-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

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
Changes since v2:
- Add a text explaining why 'memory' and 'chosen' are needed to prevent
future cleanups (Uwe).

 arch/arm/boot/dts/imx1.dtsi    | 8 ++++++++
 arch/arm/boot/dts/imx23.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx25.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx27.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx28.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx31.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx35.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx50.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx51.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx53.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
 arch/arm/boot/dts/imx6sl.dtsi  | 8 ++++++++
 arch/arm/boot/dts/imx6sx.dtsi  | 8 ++++++++
 arch/arm/boot/dts/imx6ul.dtsi  | 8 ++++++++
 arch/arm/boot/dts/imx7s.dtsi   | 8 ++++++++
 15 files changed, 120 insertions(+)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index dd3de38..38d712b 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -18,6 +18,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 96eae64..10d57f9 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -16,6 +16,14 @@
 	#size-cells = <1>;
 
 	interrupt-parent = <&icoll>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		gpio0 = &gpio0;
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 213d86e..e0ba550 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -14,6 +14,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 6a7cb9e..15d85f1 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -19,6 +19,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 905bdb5..148fcf4 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -17,6 +17,14 @@
 	#size-cells = <1>;
 
 	interrupt-parent = <&icoll>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &mac0;
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index c0a5d5f..a720314 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -12,6 +12,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		serial0 = &uart1;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 6f7b943..6d5e6a6 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -13,6 +13,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index fe0221e..ceae909 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -17,6 +17,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 33526ca..1ee1d54 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -19,6 +19,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index ca51dc0..2e516f4 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -19,6 +19,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 89b834f..e7d30f4 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -16,6 +16,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 19cbd87..cc9572e 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -14,6 +14,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 10f3330..dd4ec85 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -15,6 +15,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		can0 = &flexcan1;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 0f69a3f..bdc31f5 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -15,6 +15,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		ethernet0 = &fec1;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 8db1eb9..5d3a43b 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -50,6 +50,14 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
+	/*
+	 * The decompressor and also some bootloaders rely on a
+	 * pre-existing /chosen node to be available to insert the
+	 * command line and merge other ATAGS info.
+	 * Also for U-Boot there must be a pre-existing /memory node.
+	 */
+	chosen {};
+	memory { device_type = "memory"; reg = <0 0>; };
 
 	aliases {
 		gpio0 = &gpio1;
-- 
2.7.4
