From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 10 Mar 2015 16:27:09 +0100
Subject: [PATCH v2 1/2] ARM: dts: sunxi: Add address- and size-cells
 properties to the mmc ctrl nodes
In-Reply-To: <1426001230-15906-1-git-send-email-hdegoede@redhat.com>
References: <1426001230-15906-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1426001230-15906-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes we need to specify non-probably information for sdio devices in the
devicetree, this is done through child nodes addressed by the reg property,
whereby the reg property refers to the sdio function number, see;
Documentation/devicetree/bindings/mmc/mmc.txt

This commit adds the necessary address- and size-cells properties to the mmc
controller nodes in the dtsi files, so that dts files needing such a child
node do not need to specify these themselves.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++++++
 arch/arm/boot/dts/sun5i.dtsi     | 6 ++++++
 arch/arm/boot/dts/sun6i-a31.dtsi | 8 ++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 arch/arm/boot/dts/sun8i-a23.dtsi | 6 ++++++
 arch/arm/boot/dts/sun9i-a80.dtsi | 8 ++++++++
 6 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index e550415..48f96cd 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -527,6 +527,8 @@
 				      "sample";
 			interrupts = <32>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc1: mmc at 01c10000 {
@@ -542,6 +544,8 @@
 				      "sample";
 			interrupts = <33>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc2: mmc at 01c11000 {
@@ -557,6 +561,8 @@
 				      "sample";
 			interrupts = <34>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc3: mmc at 01c12000 {
@@ -572,6 +578,8 @@
 				      "sample";
 			interrupts = <35>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		usb_otg: usb at 01c13000 {
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index cf730d4..ca15d35 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -352,6 +352,8 @@
 				      "sample";
 			interrupts = <32>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc1: mmc at 01c10000 {
@@ -367,6 +369,8 @@
 				      "sample";
 			interrupts = <33>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc2: mmc at 01c11000 {
@@ -382,6 +386,8 @@
 				      "sample";
 			interrupts = <34>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		usb_otg: usb at 01c13000 {
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index fa2f403..96563d3 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -402,6 +402,8 @@
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc1: mmc at 01c10000 {
@@ -419,6 +421,8 @@
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc2: mmc at 01c11000 {
@@ -436,6 +440,8 @@
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc3: mmc at 01c12000 {
@@ -453,6 +459,8 @@
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		usbphy: phy at 01c19400 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 1d0b9ac..9ddefcd 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -606,6 +606,8 @@
 				      "sample";
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc1: mmc at 01c10000 {
@@ -621,6 +623,8 @@
 				      "sample";
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc2: mmc at 01c11000 {
@@ -636,6 +640,8 @@
 				      "sample";
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc3: mmc at 01c12000 {
@@ -651,6 +657,8 @@
 				      "sample";
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		usb_otg: usb at 01c13000 {
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 382ebd1..85e7b2b 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -286,6 +286,8 @@
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc1: mmc at 01c10000 {
@@ -303,6 +305,8 @@
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc2: mmc at 01c11000 {
@@ -320,6 +324,8 @@
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		pio: pinctrl at 01c20800 {
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 2f7f82c..abe7bbf 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -447,6 +447,8 @@
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc1: mmc at 01c10000 {
@@ -459,6 +461,8 @@
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc2: mmc at 01c11000 {
@@ -471,6 +475,8 @@
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc3: mmc at 01c12000 {
@@ -483,6 +489,8 @@
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		mmc_config_clk: clk at 01c13000 {
-- 
2.3.1
