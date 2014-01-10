From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 10 Jan 2014 15:22:11 +0530
Subject: [GIT PULL] DaVinci DT updates for v3.14
Message-ID: <52CFC2CB.3050909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:

  Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.14/dt

for you to fetch changes up to 3a9574f2aa4ffd9b867321a1f298893410bd3718:

  ARM: davinci: da850 evm: add GPIO pinumux entries DT node (2013-12-15 18:40:49 +0530)

----------------------------------------------------------------
DaVinci device tree file updates to add GPIO
support.

----------------------------------------------------------------
KV Sujith (2):
      ARM: davinci: da850: add GPIO DT node
      ARM: davinci: da850 evm: add GPIO pinumux entries DT node

 arch/arm/boot/dts/da850-evm.dts |    3 +++
 arch/arm/boot/dts/da850.dtsi    |   14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 588ce58..1e11e5a 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -101,6 +101,9 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mii_pins>;
 		};
+		gpio: gpio at 1e26000 {
+			status = "okay";
+		};
 	};
 	nand_cs3 at 62000000 {
 		status = "okay";
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 8d17346..b695548 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -8,6 +8,7 @@
  * option) any later version.
  */
 #include "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	arm {
@@ -256,6 +257,19 @@
 					36
 					>;
 		};
+		gpio: gpio at 1e26000 {
+			compatible = "ti,dm6441-gpio";
+			gpio-controller;
+			reg = <0x226000 0x1000>;
+			interrupts = <42 IRQ_TYPE_EDGE_BOTH
+				43 IRQ_TYPE_EDGE_BOTH 44 IRQ_TYPE_EDGE_BOTH
+				45 IRQ_TYPE_EDGE_BOTH 46 IRQ_TYPE_EDGE_BOTH
+				47 IRQ_TYPE_EDGE_BOTH 48 IRQ_TYPE_EDGE_BOTH
+				49 IRQ_TYPE_EDGE_BOTH 50 IRQ_TYPE_EDGE_BOTH>;
+			ti,ngpio = <144>;
+			ti,davinci-gpio-unbanked = <0>;
+			status = "disabled";
+		};
 	};
 	nand_cs3 at 62000000 {
 		compatible = "ti,davinci-nand";
