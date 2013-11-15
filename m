From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:53:57 -0700
Subject: [PATCH 02/31] ARM: tegra: document reset properties in DT bindings
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Update all the Tegra DT bindings to require resets/reset-names properties
where the HW module has reset inputs. Remove any entries from clocks or
clock-names that were only required to identify reset inputs, rather than
referring to real clocks.

This is a DT-ABI-incompatible change. It is the first of two changes
required for me to consider the Tegra DT bindings as stable, the other
being conversion to the common DMA DT bindings.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../bindings/clock/nvidia,tegra114-car.txt         |  4 ++
 .../bindings/clock/nvidia,tegra124-car.txt         |  4 ++
 .../bindings/clock/nvidia,tegra20-car.txt          |  4 ++
 .../bindings/clock/nvidia,tegra30-car.txt          |  4 ++
 .../devicetree/bindings/dma/tegra20-apbdma.txt     |  6 +++
 .../bindings/gpu/nvidia,tegra20-host1x.txt         | 63 ++++++++++++++++++++++
 .../devicetree/bindings/i2c/nvidia,tegra20-i2c.txt |  6 +++
 .../bindings/input/nvidia,tegra20-kbc.txt          |  6 +++
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  6 +++
 .../devicetree/bindings/nvec/nvidia,nvec.txt       |  4 ++
 .../bindings/pci/nvidia,tegra20-pcie.txt           | 14 +++--
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |  6 +++
 .../bindings/serial/nvidia,tegra20-hsuart.txt      |  6 +++
 .../bindings/sound/nvidia,tegra20-ac97.txt         |  6 +++
 .../bindings/sound/nvidia,tegra20-i2s.txt          |  6 +++
 .../bindings/sound/nvidia,tegra30-ahub.txt         | 17 ++++--
 .../bindings/sound/nvidia,tegra30-i2s.txt          |  6 +++
 .../bindings/spi/nvidia,tegra114-spi.txt           |  6 +++
 .../bindings/spi/nvidia,tegra20-sflash.txt         |  6 +++
 .../bindings/spi/nvidia,tegra20-slink.txt          |  6 +++
 .../bindings/usb/nvidia,tegra20-ehci.txt           |  4 ++
 21 files changed, 181 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt
index 0c80c2677104..9acea9d93160 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt
@@ -15,6 +15,9 @@ Required properties :
   In clock consumers, this cell represents the clock ID exposed by the
   CAR. The assignments may be found in header file
   <dt-bindings/clock/tegra114-car.h>.
+- #reset-cells : Should be 1.
+  In clock consumers, this cell represents the bit number in the CAR's
+  array of CLK_RST_CONTROLLER_RST_DEVICES_* registers.
 
 Example SoC include file:
 
@@ -23,6 +26,7 @@ Example SoC include file:
 		compatible = "nvidia,tegra114-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	usb at c5004000 {
diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.txt
index 1a91ec60dee5..ded5d6212c84 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.txt
@@ -15,6 +15,9 @@ Required properties :
   In clock consumers, this cell represents the clock ID exposed by the
   CAR. The assignments may be found in header file
   <dt-bindings/clock/tegra124-car.h>.
+- #reset-cells : Should be 1.
+  In clock consumers, this cell represents the bit number in the CAR's
+  array of CLK_RST_CONTROLLER_RST_DEVICES_* registers.
 
 Example SoC include file:
 
@@ -23,6 +26,7 @@ Example SoC include file:
 		compatible = "nvidia,tegra124-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	usb at c5004000 {
diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt
index fcfed5bf73fb..6c5901b503d0 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt
@@ -15,6 +15,9 @@ Required properties :
   In clock consumers, this cell represents the clock ID exposed by the
   CAR. The assignments may be found in header file
   <dt-bindings/clock/tegra20-car.h>.
+- #reset-cells : Should be 1.
+  In clock consumers, this cell represents the bit number in the CAR's
+  array of CLK_RST_CONTROLLER_RST_DEVICES_* registers.
 
 Example SoC include file:
 
@@ -23,6 +26,7 @@ Example SoC include file:
 		compatible = "nvidia,tegra20-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	usb at c5004000 {
diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt
index 0f714081e986..63618cde12df 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt
@@ -15,6 +15,9 @@ Required properties :
   In clock consumers, this cell represents the clock ID exposed by the
   CAR. The assignments may be found in header file
   <dt-bindings/clock/tegra30-car.h>.
+- #reset-cells : Should be 1.
+  In clock consumers, this cell represents the bit number in the CAR's
+  array of CLK_RST_CONTROLLER_RST_DEVICES_* registers.
 
 Example SoC include file:
 
@@ -23,6 +26,7 @@ Example SoC include file:
 		compatible = "nvidia,tegra30-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	usb at c5004000 {
diff --git a/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt b/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
index 74bfc54bb184..0b1e577ab9d3 100644
--- a/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
+++ b/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
@@ -7,6 +7,10 @@ Required properties:
 - interrupts: Should contain all of the per-channel DMA interrupts.
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - dma
 
 Examples:
 
@@ -30,4 +34,6 @@ apbdma: dma at 6000a000 {
 		       0 150 0x04
 		       0 151 0x04 >;
 	clocks = <&tegra_car 34>;
+	resets = <&tegra_car 34>;
+	reset-names = "dma";
 };
diff --git a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
index c9a715a75f60..8e22d234dc4c 100644
--- a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
@@ -11,6 +11,10 @@ Required properties:
 - ranges: The mapping of the host1x address space to the CPU address space.
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - host1x
 
 The host1x top-level node defines a number of children, each representing one
 of the following host1x client modules:
@@ -23,6 +27,10 @@ of the following host1x client modules:
   - interrupts: The interrupt outputs from the controller.
   - clocks : Must contain one entry, for the module clock.
     See ../clocks/clock-bindings.txt for details.
+  - resets : Must contain an entry for each entry in reset-names.
+    See ../reset/reset.txt for details.
+  - reset-names : Must include the following entries:
+    - mpe
 
 - vi: video input
 
@@ -32,6 +40,10 @@ of the following host1x client modules:
   - interrupts: The interrupt outputs from the controller.
   - clocks : Must contain one entry, for the module clock.
     See ../clocks/clock-bindings.txt for details.
+  - resets : Must contain an entry for each entry in reset-names.
+    See ../reset/reset.txt for details.
+  - reset-names : Must include the following entries:
+    - vi
 
 - epp: encoder pre-processor
 
@@ -41,6 +53,10 @@ of the following host1x client modules:
   - interrupts: The interrupt outputs from the controller.
   - clocks : Must contain one entry, for the module clock.
     See ../clocks/clock-bindings.txt for details.
+  - resets : Must contain an entry for each entry in reset-names.
+    See ../reset/reset.txt for details.
+  - reset-names : Must include the following entries:
+    - epp
 
 - isp: image signal processor
 
@@ -50,6 +66,10 @@ of the following host1x client modules:
   - interrupts: The interrupt outputs from the controller.
   - clocks : Must contain one entry, for the module clock.
     See ../clocks/clock-bindings.txt for details.
+  - resets : Must contain an entry for each entry in reset-names.
+    See ../reset/reset.txt for details.
+  - reset-names : Must include the following entries:
+    - isp
 
 - gr2d: 2D graphics engine
 
@@ -59,6 +79,10 @@ of the following host1x client modules:
   - interrupts: The interrupt outputs from the controller.
   - clocks : Must contain one entry, for the module clock.
     See ../clocks/clock-bindings.txt for details.
+  - resets : Must contain an entry for each entry in reset-names.
+    See ../reset/reset.txt for details.
+  - reset-names : Must include the following entries:
+    - 2d
 
 - gr3d: 3D graphics engine
 
@@ -74,6 +98,11 @@ of the following host1x client modules:
     - 3d
       This MUST be the first entry.
     - 3d2 (Only required on SoCs with two 3D clocks)
+  - resets : Must contain an entry for each entry in reset-names.
+    See ../reset/reset.txt for details.
+  - reset-names : Must include the following entries:
+    - 3d
+    - 3d2 (Only required on SoCs with two 3D clocks)
 
 - dc: display controller
 
@@ -87,6 +116,10 @@ of the following host1x client modules:
     - disp1 or disp2 (depending on the controller instance)
       This MUST be the first entry.
     - parent
+  - resets : Must contain an entry for each entry in reset-names.
+    See ../reset/reset.txt for details.
+  - reset-names : Must include the following entries:
+    - dc
 
   Each display controller node has a child node, named "rgb", that represents
   the RGB output associated with the controller. It can take the following
@@ -109,6 +142,10 @@ of the following host1x client modules:
     - hdmi
       This MUST be the first entry.
     - parent
+  - resets : Must contain an entry for each entry in reset-names.
+    See ../reset/reset.txt for details.
+  - reset-names : Must include the following entries:
+    - hdmi
 
   Optional properties:
   - nvidia,ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
@@ -137,6 +174,10 @@ of the following host1x client modules:
     - dsi
       This MUST be the first entry.
     - parent
+  - resets : Must contain an entry for each entry in reset-names.
+    See ../reset/reset.txt for details.
+  - reset-names : Must include the following entries:
+    - dsi
 
 Example:
 
@@ -149,6 +190,8 @@ Example:
 		interrupts = <0 65 0x04   /* mpcore syncpt */
 			      0 67 0x04>; /* mpcore general */
 		clocks = <&tegra_car TEGRA20_CLK_HOST1X>;
+		resets = <&tegra_car 28>;
+		reset-names = "host1x";
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -160,6 +203,8 @@ Example:
 			reg = <0x54040000 0x00040000>;
 			interrupts = <0 68 0x04>;
 			clocks = <&tegra_car TEGRA20_CLK_MPE>;
+			resets = <&tegra_car 60>;
+			reset-names = "mpe";
 		};
 
 		vi {
@@ -167,6 +212,8 @@ Example:
 			reg = <0x54080000 0x00040000>;
 			interrupts = <0 69 0x04>;
 			clocks = <&tegra_car TEGRA20_CLK_VI>;
+			resets = <&tegra_car 100>;
+			reset-names = "vi";
 		};
 
 		epp {
@@ -174,6 +221,8 @@ Example:
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <0 70 0x04>;
 			clocks = <&tegra_car TEGRA20_CLK_EPP>;
+			resets = <&tegra_car 19>;
+			reset-names = "epp";
 		};
 
 		isp {
@@ -181,6 +230,8 @@ Example:
 			reg = <0x54100000 0x00040000>;
 			interrupts = <0 71 0x04>;
 			clocks = <&tegra_car TEGRA20_CLK_ISP>;
+			resets = <&tegra_car 23>;
+			reset-names = "isp";
 		};
 
 		gr2d {
@@ -188,12 +239,16 @@ Example:
 			reg = <0x54140000 0x00040000>;
 			interrupts = <0 72 0x04>;
 			clocks = <&tegra_car TEGRA20_CLK_GR2D>;
+			resets = <&tegra_car 21>;
+			reset-names = "2d";
 		};
 
 		gr3d {
 			compatible = "nvidia,tegra20-gr3d";
 			reg = <0x54180000 0x00040000>;
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
+			resets = <&tegra_car 24>;
+			reset-names = "3d";
 		};
 
 		dc at 54200000 {
@@ -203,6 +258,8 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_DISP1>,
 				 <&tegra_car TEGRA20_CLK_PLL_P>;
 			clock-names = "disp1", "parent";
+			resets = <&tegra_car 27>;
+			reset-names = "dc";
 
 			rgb {
 				status = "disabled";
@@ -216,6 +273,8 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_DISP2>,
 				 <&tegra_car TEGRA20_CLK_PLL_P>;
 			clock-names = "disp2", "parent";
+			resets = <&tegra_car 26>;
+			reset-names = "dc";
 
 			rgb {
 				status = "disabled";
@@ -229,6 +288,8 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_HDMI>,
 				 <&tegra_car TEGRA20_CLK_PLL_D_OUT0>;
 			clock-names = "hdmi", "parent";
+			resets = <&tegra_car 51>;
+			reset-names = "hdmi";
 			status = "disabled";
 		};
 
@@ -244,6 +305,8 @@ Example:
 			compatible = "nvidia,tegra20-dsi";
 			reg = <0x54300000 0x00040000>;
 			clocks = <&tegra_car TEGRA20_CLK_DSI>;
+			resets = <&tegra_car 48>;
+			reset-names = "dsi";
 			status = "disabled";
 		};
 	};
diff --git a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
index 96ab40131ae1..2b3af72dfb9c 100644
--- a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
@@ -47,6 +47,10 @@ Required properties:
   - fast-clk
   Tegra114:
   - div-clk
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - i2c
 
 Example:
 
@@ -58,5 +62,7 @@ Example:
 		#size-cells = <0>;
 		clocks = <&tegra_car 12>, <&tegra_car 124>;
 		clock-names = "div-clk", "fast-clk";
+		resets = <&tegra_car 12>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
index cc28d2194c37..83b14b6389fc 100644
--- a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
+++ b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
@@ -15,6 +15,10 @@ Required properties:
   devicetree/bindings/input/matrix-keymap.txt.
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - kbc
 
 Optional properties, in addition to those specified by the shared
 matrix-keyboard bindings:
@@ -34,6 +38,8 @@ keyboard: keyboard {
 	reg = <0x7000e200 0x100>;
 	interrupts = <0 85 0x04>;
 	clocks = <&tegra_car 36>;
+	resets = <&tegra_car 36>;
+	reset-names = "kbc";
 	nvidia,ghost-filter;
 	nvidia,debounce-delay-ms = <640>;
 	nvidia,kbc-row-pins = <0 1 2>;    /* pin 0, 1, 2 as rows */
diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index f727902a9e8d..f357c16ea815 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -10,6 +10,10 @@ Required properties:
 - compatible : Should be "nvidia,<chip>-sdhci"
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - sdhci
 
 Optional properties:
 - power-gpios : Specify GPIOs for power control
@@ -21,6 +25,8 @@ sdhci at c8000200 {
 	reg = <0xc8000200 0x200>;
 	interrupts = <47>;
 	clocks = <&tegra_car 14>;
+	resets = <&tegra_car 14>;
+	reset-names = "sdhci";
 	cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 	wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 	power-gpios = <&gpio 155 0>; /* gpio PT3 */
diff --git a/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt b/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
index a97fe575ca29..5ae601e7f51f 100644
--- a/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
+++ b/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
@@ -15,3 +15,7 @@ Required properties:
   - fast-clk
   Tegra114:
   - div-clk
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - i2c
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index ad2eb9804afa..6d91016100b3 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -47,9 +47,14 @@ Required properties:
 - clock-names : Must include the following entries:
   - pex
   - afi
-  - pcie_xclk
   - pll_e
   - cml (not required for Tegra20)
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - pex
+  - afi
+  - pcie_x
 
 Root ports are defined as subnodes of the PCIe controller node.
 
@@ -91,9 +96,10 @@ SoC DTSI:
 			  0x82000000 0 0xa0000000 0xa0000000 0 0x10000000   /* non-prefetchable memory */
 			  0xc2000000 0 0xb0000000 0xb0000000 0 0x10000000>; /* prefetchable memory */
 
-		clocks = <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>,
-			 <&tegra_car 118>;
-		clock-names = "pex", "afi", "pcie_xclk", "pll_e";
+		clocks = <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 118>;
+		clock-names = "pex", "afi", "pll_e";
+		resets = <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>;
+		reset-names = "pex", "afi", "pcie_x";
 		status = "disabled";
 
 		pci at 1,0 {
diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index 0d608d34fed0..a65d4c3be231 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -9,6 +9,10 @@ Required properties:
   the cells format.
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - pwm
 
 Example:
 
@@ -17,4 +21,6 @@ Example:
 		reg = <0x7000a000 0x100>;
 		#pwm-cells = <2>;
 		clocks = <&tegra_car 17>;
+		resets = <&tegra_car 17>;
+		reset-names = "pwm";
 	};
diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
index 39148b6236a1..69ccdbe3760e 100644
--- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
@@ -8,6 +8,10 @@ Required properties:
   request selector for this UART controller.
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - serial
 
 Optional properties:
 - nvidia,enable-modem-interrupt: Enable modem interrupts. Should be enable
@@ -23,5 +27,7 @@ serial at 70006000 {
 	nvidia,dma-request-selector = <&apbdma 8>;
 	nvidia,enable-modem-interrupt;
 	clocks = <&tegra_car 6>;
+	resets = <&tegra_car 6>;
+	reset-names = "serial";
 	status = "disabled";
 };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
index 37f4ebf5b184..2b6817f6e40e 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
@@ -6,6 +6,10 @@ Required properties:
 - interrupts : Should contain AC97 interrupt
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - ac97
 - nvidia,dma-request-selector : The Tegra DMA controller's phandle and
   request selector for the AC97 controller
 - nvidia,codec-reset-gpio : The Tegra GPIO controller's phandle and the number
@@ -23,4 +27,6 @@ ac97 at 70002000 {
 	nvidia,codec-reset-gpio = <&gpio 170 0>;
 	nvidia,codec-sync-gpio = <&gpio 120 0>;
 	clocks = <&tegra_car 3>;
+	resets = <&tegra_car 3>;
+	reset-names = "ac97";
 };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
index ba0c9452916d..8b070aeca3db 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
@@ -6,6 +6,10 @@ Required properties:
 - interrupts : Should contain I2S interrupt
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - i2s
 - nvidia,dma-request-selector : The Tegra DMA controller's phandle and
   request selector for this I2S controller
 
@@ -17,4 +21,6 @@ i2s at 70002800 {
 	interrupts = < 45 >;
 	nvidia,dma-request-selector = < &apbdma 2 >;
 	clocks = <&tegra_car 11>;
+	resets = <&tegra_car 11>;
+	reset-names = "i2s";
 };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
index 7299eeadd588..60d59a54ca07 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
@@ -15,6 +15,11 @@ Required properties:
 - clocks : Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entries:
+  - d_audio
+  - apbif
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
   Tegra30 and later:
   - d_audio
   - apbif
@@ -26,7 +31,7 @@ Required properties:
   - dam0
   - dam1
   - dam2
-  - spdif_in
+  - spdif
   Tegra114 and later additionally require:
   - amx
   - adx
@@ -48,13 +53,15 @@ ahub at 70080000 {
 	reg = <0x70080000 0x200 0x70080200 0x100>;
 	interrupts = < 0 103 0x04 >;
 	nvidia,dma-request-selector = <&apbdma 1>;
-	clocks = <&tegra_car 106>, <&tegra_car 107>, <&tegra_car 30>,
+	clocks = <&tegra_car 106>, <&tegra_car 107>;
+	clock-names = "d_audio", "apbif";
+	resets = <&tegra_car 106>, <&tegra_car 107>, <&tegra_car 30>,
 		<&tegra_car 11>, <&tegra_car 18>, <&tegra_car 101>,
 		<&tegra_car 102>, <&tegra_car 108>, <&tegra_car 109>,
-		<&tegra_car 110>, <&tegra_car 162>;
-	clock-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
+		<&tegra_car 110>, <&tegra_car 10>;
+	reset-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
 		"i2s3", "i2s4", "dam0", "dam1", "dam2",
-		"spdif_in";
+		"spdif";
 	ranges;
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
index 7a3112bc135c..0c113ffe3814 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
@@ -5,6 +5,10 @@ Required properties:
 - reg : Should contain I2S registers location and length
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - i2s
 - nvidia,ahub-cif-ids : The list of AHUB CIF IDs for this port, rx (playback)
   first, tx (capture) second. See nvidia,tegra30-ahub.txt for values.
 
@@ -15,4 +19,6 @@ i2s at 70080300 {
 	reg = <0x70080300 0x100>;
 	nvidia,ahub-cif-ids = <4 4>;
 	clocks = <&tegra_car 11>;
+	resets = <&tegra_car 11>;
+	reset-names = "i2s";
 };
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
index d4f2d534934b..fcd9f67999de 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
@@ -10,6 +10,10 @@ Required properties:
   See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entries:
   - spi
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - spi
 
 Recommended properties:
 - spi-max-frequency: Definition as per
@@ -26,5 +30,7 @@ spi at 7000d600 {
 	#size-cells = <0>;
 	clocks = <&tegra_car 44>;
 	clock-names = "spi";
+	resets = <&tegra_car 44>;
+	reset-names = "spi";
 	status = "disabled";
 };
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
index 66e16c7f5939..e144f144717f 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
@@ -8,6 +8,10 @@ Required properties:
   request selector for this SFLASH controller.
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - spi
 
 Recommended properties:
 - spi-max-frequency: Definition as per
@@ -24,5 +28,7 @@ spi at 7000c380 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	clocks = <&tegra_car 43>;
+	resets = <&tegra_car 43>;
+	reset-names = "spi";
 	status = "disabled";
 };
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
index 0e6e94eb2b2a..9393e28f444b 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
@@ -8,6 +8,10 @@ Required properties:
   request selector for this SLINK controller.
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - spi
 
 Recommended properties:
 - spi-max-frequency: Definition as per
@@ -24,5 +28,7 @@ spi at 7000d600 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	clocks = <&tegra_car 44>;
+	resets = <&tegra_car 44>;
+	reset-names = "spi";
 	status = "disabled";
 };
diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
index b98d0bdfa248..3dc9140e3dfb 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
@@ -10,6 +10,10 @@ Required properties :
  - nvidia,phy : phandle of the PHY that the controller is connected to.
  - clocks : Must contain one entry, for the module clock.
    See ../clocks/clock-bindings.txt for details.
+ - resets : Must contain an entry for each entry in reset-names.
+   See ../reset/reset.txt for details.
+ - reset-names : Must include the following entries:
+   - usb
 
 Optional properties:
  - nvidia,needs-double-reset : boolean is to be set for some of the Tegra20
-- 
1.8.1.5
