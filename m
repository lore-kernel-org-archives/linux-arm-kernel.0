From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Oct 2017 12:54:52 -0500
Subject: [PATCH 2/2] arm64: dts: fix unit-address leading 0s
In-Reply-To: <20171013175452.1198-1-robh@kernel.org>
References: <20171013175452.1198-1-robh@kernel.org>
Message-ID: <20171013175452.1198-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix dtc warnings for 'simple_bus_reg' due to leading 0s. Converted using
the following command:

perl -p -i -e 's/\@0+([0-9a-f])/\@$1/g' `find arch/arm64/boot/dts -type -f -name '*.dts*'

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 16 +++---
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         |  6 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  4 +-
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         | 14 ++---
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |  2 +-
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi   | 24 ++++----
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |  2 +-
 .../arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts |  2 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |  4 +-
 .../boot/dts/broadcom/stingray/stingray-clock.dtsi | 12 ++--
 .../boot/dts/broadcom/stingray/stingray-fs4.dtsi   |  4 +-
 .../dts/broadcom/stingray/stingray-pinctrl.dtsi    |  4 +-
 .../boot/dts/broadcom/stingray/stingray-sata.dtsi  | 32 +++++------
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 66 +++++++++++-----------
 arch/arm64/boot/dts/cavium/thunder-88xx.dts        |  2 +-
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi       | 32 +++++------
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts        |  2 +-
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts        |  2 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |  2 +-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     |  2 +-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |  2 +-
 arch/arm64/boot/dts/marvell/armada-8080-db.dts     |  2 +-
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |  4 +-
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |  4 +-
 .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    |  4 +-
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi         |  6 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  6 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       | 10 ++--
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  6 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 12 ++--
 30 files changed, 145 insertions(+), 145 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 8c8db1b057df..0daad839f92c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -178,7 +178,7 @@
 			#size-cells = <0>;
 		};
 
-		usb_otg: usb at 01c19000 {
+		usb_otg: usb at 1c19000 {
 			compatible = "allwinner,sun8i-a33-musb";
 			reg = <0x01c19000 0x0400>;
 			clocks = <&ccu CLK_BUS_OTG>;
@@ -191,7 +191,7 @@
 			status = "disabled";
 		};
 
-		usbphy: phy at 01c19400 {
+		usbphy: phy at 1c19400 {
 			compatible = "allwinner,sun50i-a64-usb-phy";
 			reg = <0x01c19400 0x14>,
 			      <0x01c1a800 0x4>,
@@ -211,7 +211,7 @@
 			#phy-cells = <1>;
 		};
 
-		ehci0: usb at 01c1a000 {
+		ehci0: usb at 1c1a000 {
 			compatible = "allwinner,sun50i-a64-ehci", "generic-ehci";
 			reg = <0x01c1a000 0x100>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
@@ -223,7 +223,7 @@
 			status = "disabled";
 		};
 
-		ohci0: usb at 01c1a400 {
+		ohci0: usb at 1c1a400 {
 			compatible = "allwinner,sun50i-a64-ohci", "generic-ohci";
 			reg = <0x01c1a400 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
@@ -233,7 +233,7 @@
 			status = "disabled";
 		};
 
-		ehci1: usb at 01c1b000 {
+		ehci1: usb at 1c1b000 {
 			compatible = "allwinner,sun50i-a64-ehci", "generic-ehci";
 			reg = <0x01c1b000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
@@ -247,7 +247,7 @@
 			status = "disabled";
 		};
 
-		ohci1: usb at 01c1b400 {
+		ohci1: usb at 1c1b400 {
 			compatible = "allwinner,sun50i-a64-ohci", "generic-ohci";
 			reg = <0x01c1b400 0x100>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
@@ -259,7 +259,7 @@
 			status = "disabled";
 		};
 
-		ccu: clock at 01c20000 {
+		ccu: clock at 1c20000 {
 			compatible = "allwinner,sun50i-a64-ccu";
 			reg = <0x01c20000 0x400>;
 			clocks = <&osc24M>, <&osc32k>;
@@ -486,7 +486,7 @@
 			#reset-cells = <1>;
 		};
 
-		r_pio: pinctrl at 01f02c00 {
+		r_pio: pinctrl at 1f02c00 {
 			compatible = "allwinner,sun50i-a64-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index c9ffffb96e43..d8ecd1661461 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -19,7 +19,7 @@
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		cpu at 000 {
+		cpu at 0 {
 			device_type = "cpu";
 			compatible = "apm,strega", "arm,armv8";
 			reg = <0x0 0x000>;
@@ -29,7 +29,7 @@
 			#clock-cells = <1>;
 			clocks = <&pmd0clk 0>;
 		};
-		cpu at 001 {
+		cpu at 1 {
 			device_type = "cpu";
 			compatible = "apm,strega", "arm,armv8";
 			reg = <0x0 0x001>;
@@ -125,7 +125,7 @@
 		      <0x0 0x780a0000 0x0 0x20000>,	/* GIC CPU */
 		      <0x0 0x780c0000 0x0 0x10000>,	/* GIC VCPU Control */
 		      <0x0 0x780e0000 0x0 0x20000>;	/* GIC VCPU */
-		v2m0: v2m at 00000 {
+		v2m0: v2m at 0 {
 			compatible = "arm,gic-v2m-frame";
 			msi-controller;
 			reg = <0x0 0x0 0x0 0x1000>;
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index c09a36fed917..00e82b8e9a19 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -19,7 +19,7 @@
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		cpu at 000 {
+		cpu at 0 {
 			device_type = "cpu";
 			compatible = "apm,potenza", "arm,armv8";
 			reg = <0x0 0x000>;
@@ -27,7 +27,7 @@
 			cpu-release-addr = <0x1 0x0000fff8>;
 			next-level-cache = <&xgene_L2_0>;
 		};
-		cpu at 001 {
+		cpu at 1 {
 			device_type = "cpu";
 			compatible = "apm,potenza", "arm,armv8";
 			reg = <0x0 0x001>;
diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
index 8ecdd4331980..21a7a575f02c 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
@@ -97,7 +97,7 @@
 		timeout-sec = <30>;
 	};
 
-	smb at 08000000 {
+	smb at 8000000 {
 		compatible = "arm,vexpress,v2m-p1", "simple-bus";
 		arm,v2m-memory-map = "rs1";
 		#address-cells = <2>; /* SMB chipselect number and offset */
@@ -189,12 +189,12 @@
 			#size-cells = <1>;
 			ranges = <0 3 0 0x200000>;
 
-			v2m_sysreg: sysreg at 010000 {
+			v2m_sysreg: sysreg at 10000 {
 				compatible = "arm,vexpress-sysreg";
 				reg = <0x010000 0x1000>;
 			};
 
-			v2m_serial0: uart at 090000 {
+			v2m_serial0: uart at 90000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x090000 0x1000>;
 				interrupts = <5>;
@@ -202,7 +202,7 @@
 				clock-names = "uartclk", "apb_pclk";
 			};
 
-			v2m_serial1: uart at 0a0000 {
+			v2m_serial1: uart at a0000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0a0000 0x1000>;
 				interrupts = <6>;
@@ -210,7 +210,7 @@
 				clock-names = "uartclk", "apb_pclk";
 			};
 
-			v2m_serial2: uart at 0b0000 {
+			v2m_serial2: uart at b0000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0b0000 0x1000>;
 				interrupts = <7>;
@@ -218,7 +218,7 @@
 				clock-names = "uartclk", "apb_pclk";
 			};
 
-			v2m_serial3: uart at 0c0000 {
+			v2m_serial3: uart at c0000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0c0000 0x1000>;
 				interrupts = <8>;
@@ -226,7 +226,7 @@
 				clock-names = "uartclk", "apb_pclk";
 			};
 
-			virtio-block at 0130000 {
+			virtio-block at 130000 {
 				compatible = "virtio,mmio";
 				reg = <0x130000 0x200>;
 				interrupts = <42>;
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
index a83ed2c6bbf7..a1b73f46b625 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
@@ -104,7 +104,7 @@
 			     <0 63 4>;
 	};
 
-	smb at 08000000 {
+	smb at 8000000 {
 		compatible = "simple-bus";
 
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
index 528875c75598..6cadb779729d 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
@@ -60,14 +60,14 @@
 			#size-cells = <1>;
 			ranges = <0 3 0 0x200000>;
 
-			v2m_sysreg: sysreg at 010000 {
+			v2m_sysreg: sysreg at 10000 {
 				compatible = "arm,vexpress-sysreg";
 				reg = <0x010000 0x1000>;
 				gpio-controller;
 				#gpio-cells = <2>;
 			};
 
-			v2m_sysctl: sysctl at 020000 {
+			v2m_sysctl: sysctl at 20000 {
 				compatible = "arm,sp810", "arm,primecell";
 				reg = <0x020000 0x1000>;
 				clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&v2m_clk24mhz>;
@@ -78,7 +78,7 @@
 				assigned-clock-parents = <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>;
 			};
 
-			aaci at 040000 {
+			aaci at 40000 {
 				compatible = "arm,pl041", "arm,primecell";
 				reg = <0x040000 0x1000>;
 				interrupts = <11>;
@@ -86,7 +86,7 @@
 				clock-names = "apb_pclk";
 			};
 
-			mmci at 050000 {
+			mmci at 50000 {
 				compatible = "arm,pl180", "arm,primecell";
 				reg = <0x050000 0x1000>;
 				interrupts = <9 10>;
@@ -98,7 +98,7 @@
 				clock-names = "mclk", "apb_pclk";
 			};
 
-			kmi at 060000 {
+			kmi at 60000 {
 				compatible = "arm,pl050", "arm,primecell";
 				reg = <0x060000 0x1000>;
 				interrupts = <12>;
@@ -106,7 +106,7 @@
 				clock-names = "KMIREFCLK", "apb_pclk";
 			};
 
-			kmi at 070000 {
+			kmi at 70000 {
 				compatible = "arm,pl050", "arm,primecell";
 				reg = <0x070000 0x1000>;
 				interrupts = <13>;
@@ -114,7 +114,7 @@
 				clock-names = "KMIREFCLK", "apb_pclk";
 			};
 
-			v2m_serial0: uart at 090000 {
+			v2m_serial0: uart at 90000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x090000 0x1000>;
 				interrupts = <5>;
@@ -122,7 +122,7 @@
 				clock-names = "uartclk", "apb_pclk";
 			};
 
-			v2m_serial1: uart at 0a0000 {
+			v2m_serial1: uart at a0000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0a0000 0x1000>;
 				interrupts = <6>;
@@ -130,7 +130,7 @@
 				clock-names = "uartclk", "apb_pclk";
 			};
 
-			v2m_serial2: uart at 0b0000 {
+			v2m_serial2: uart at b0000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0b0000 0x1000>;
 				interrupts = <7>;
@@ -138,7 +138,7 @@
 				clock-names = "uartclk", "apb_pclk";
 			};
 
-			v2m_serial3: uart at 0c0000 {
+			v2m_serial3: uart at c0000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x0c0000 0x1000>;
 				interrupts = <8>;
@@ -146,7 +146,7 @@
 				clock-names = "uartclk", "apb_pclk";
 			};
 
-			wdt at 0f0000 {
+			wdt at f0000 {
 				compatible = "arm,sp805", "arm,primecell";
 				reg = <0x0f0000 0x1000>;
 				interrupts = <0>;
@@ -219,7 +219,7 @@
 				};
 			};
 
-			virtio-block at 0130000 {
+			virtio-block at 130000 {
 				compatible = "virtio,mmio";
 				reg = <0x130000 0x200>;
 				interrupts = <42>;
diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
index e3a171162bb4..124dceeada1f 100644
--- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
+++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
@@ -128,7 +128,7 @@
 		};
 	};
 
-	smb at 08000000 {
+	smb at 8000000 {
 		compatible = "simple-bus";
 
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
index ab4ae1a32fab..f00c21e0767e 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
@@ -114,7 +114,7 @@
 			reg = <0x04000000 0x06400000>; /*  100MB */
 		};
 
-		partition at 0a400000{
+		partition at a400000{
 			label = "ncustfs";
 			reg = <0x0a400000 0x35c00000>; /*  860MB */
 		};
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 35c8457e3d1f..4a2a6af8e752 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -77,7 +77,7 @@
 			next-level-cache = <&CLUSTER0_L2>;
 		};
 
-		CLUSTER0_L2: l2-cache at 000 {
+		CLUSTER0_L2: l2-cache at 0 {
 			compatible = "cache";
 		};
 	};
@@ -367,7 +367,7 @@
 			#size-cells = <1>;
 			ranges = <0 0x652e0000 0x80000>;
 
-			v2m0: v2m at 00000 {
+			v2m0: v2m at 0 {
 				compatible = "arm,gic-v2m-frame";
 				interrupt-parent = <&gic>;
 				msi-controller;
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi
index cbc43376e25e..3a4d4524b5ed 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi
@@ -46,7 +46,7 @@
 			clock-mult = <1>;
 		};
 
-		genpll0: genpll0 at 0001d104 {
+		genpll0: genpll0 at 1d104 {
 			#clock-cells = <1>;
 			compatible = "brcm,sr-genpll0";
 			reg = <0x0001d104 0x32>,
@@ -58,7 +58,7 @@
 					     "clk_paxc_axi";
 		};
 
-		genpll3: genpll3 at 0001d1e0 {
+		genpll3: genpll3 at 1d1e0 {
 			#clock-cells = <1>;
 			compatible = "brcm,sr-genpll3";
 			reg = <0x0001d1e0 0x32>,
@@ -68,7 +68,7 @@
 					     "clk_sdio";
 		};
 
-		genpll4: genpll4 at 0001d214 {
+		genpll4: genpll4 at 1d214 {
 			#clock-cells = <1>;
 			compatible = "brcm,sr-genpll4";
 			reg = <0x0001d214 0x32>,
@@ -80,7 +80,7 @@
 					     "clk_bridge_fscpu";
 		};
 
-		genpll5: genpll5 at 0001d248 {
+		genpll5: genpll5 at 1d248 {
 			#clock-cells = <1>;
 			compatible = "brcm,sr-genpll5";
 			reg = <0x0001d248 0x32>,
@@ -90,7 +90,7 @@
 					     "crypto_ae_clk", "raid_ae_clk";
 		};
 
-		lcpll0: lcpll0 at 0001d0c4 {
+		lcpll0: lcpll0 at 1d0c4 {
 			#clock-cells = <1>;
 			compatible = "brcm,sr-lcpll0";
 			reg = <0x0001d0c4 0x3c>,
@@ -101,7 +101,7 @@
 					     "clk_sata_500";
 		};
 
-		lcpll1: lcpll1 at 0001d138 {
+		lcpll1: lcpll1 at 1d138 {
 			#clock-cells = <1>;
 			compatible = "brcm,sr-lcpll1";
 			reg = <0x0001d138 0x3c>,
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi
index 8bf1dc6b46ca..9666969c8c88 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi
@@ -36,7 +36,7 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x67000000 0x00800000>;
 
-		crypto_mbox: crypto_mbox at 00000000 {
+		crypto_mbox: crypto_mbox at 0 {
 			compatible = "brcm,iproc-flexrm-mbox";
 			reg = <0x00000000 0x200000>;
 			msi-parent = <&gic_its 0x4100>;
@@ -44,7 +44,7 @@
 			dma-coherent;
 		};
 
-		raid_mbox: raid_mbox at 00400000 {
+		raid_mbox: raid_mbox at 400000 {
 			compatible = "brcm,iproc-flexrm-mbox";
 			reg = <0x00400000 0x200000>;
 			dma-coherent;
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
index 15214d05fec1..8a3a770e8f2c 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
@@ -32,7 +32,7 @@
 
 #include <dt-bindings/pinctrl/brcm,pinctrl-stingray.h>
 
-		pinconf: pinconf at 00140000 {
+		pinconf: pinconf at 140000 {
 			compatible = "pinconf-single";
 			reg = <0x00140000 0x250>;
 			pinctrl-single,register-width = <32>;
@@ -40,7 +40,7 @@
 			/* pinconf functions */
 		};
 
-		pinmux: pinmux at 0014029c {
+		pinmux: pinmux at 14029c {
 			compatible = "pinctrl-single";
 			reg = <0x0014029c 0x250>;
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
index a774709388df..4b5465da81d8 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
@@ -36,7 +36,7 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x67d00000 0x00800000>;
 
-		sata0: ahci at 00210000 {
+		sata0: ahci at 210000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
 			reg = <0x00210000 0x1000>;
 			reg-names = "ahci";
@@ -52,7 +52,7 @@
 			};
 		};
 
-		sata_phy0: sata_phy at 00212100 {
+		sata_phy0: sata_phy at 212100 {
 			compatible = "brcm,iproc-sr-sata-phy";
 			reg = <0x00212100 0x1000>;
 			reg-names = "phy";
@@ -66,7 +66,7 @@
 			};
 		};
 
-		sata1: ahci at 00310000 {
+		sata1: ahci at 310000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
 			reg = <0x00310000 0x1000>;
 			reg-names = "ahci";
@@ -82,7 +82,7 @@
 			};
 		};
 
-		sata_phy1: sata_phy at 00312100 {
+		sata_phy1: sata_phy at 312100 {
 			compatible = "brcm,iproc-sr-sata-phy";
 			reg = <0x00312100 0x1000>;
 			reg-names = "phy";
@@ -96,7 +96,7 @@
 			};
 		};
 
-		sata2: ahci at 00120000 {
+		sata2: ahci at 120000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
 			reg = <0x00120000 0x1000>;
 			reg-names = "ahci";
@@ -112,7 +112,7 @@
 			};
 		};
 
-		sata_phy2: sata_phy at 00122100 {
+		sata_phy2: sata_phy at 122100 {
 			compatible = "brcm,iproc-sr-sata-phy";
 			reg = <0x00122100 0x1000>;
 			reg-names = "phy";
@@ -126,7 +126,7 @@
 			};
 		};
 
-		sata3: ahci at 00130000 {
+		sata3: ahci at 130000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
 			reg = <0x00130000 0x1000>;
 			reg-names = "ahci";
@@ -142,7 +142,7 @@
 			};
 		};
 
-		sata_phy3: sata_phy at 00132100 {
+		sata_phy3: sata_phy at 132100 {
 			compatible = "brcm,iproc-sr-sata-phy";
 			reg = <0x00132100 0x1000>;
 			reg-names = "phy";
@@ -156,7 +156,7 @@
 			};
 		};
 
-		sata4: ahci at 00330000 {
+		sata4: ahci at 330000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
 			reg = <0x00330000 0x1000>;
 			reg-names = "ahci";
@@ -172,7 +172,7 @@
 			};
 		};
 
-		sata_phy4: sata_phy at 00332100 {
+		sata_phy4: sata_phy at 332100 {
 			compatible = "brcm,iproc-sr-sata-phy";
 			reg = <0x00332100 0x1000>;
 			reg-names = "phy";
@@ -186,7 +186,7 @@
 			};
 		};
 
-		sata5: ahci at 00400000 {
+		sata5: ahci at 400000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
 			reg = <0x00400000 0x1000>;
 			reg-names = "ahci";
@@ -202,7 +202,7 @@
 			};
 		};
 
-		sata_phy5: sata_phy at 00402100 {
+		sata_phy5: sata_phy at 402100 {
 			compatible = "brcm,iproc-sr-sata-phy";
 			reg = <0x00402100 0x1000>;
 			reg-names = "phy";
@@ -216,7 +216,7 @@
 			};
 		};
 
-		sata6: ahci at 00410000 {
+		sata6: ahci at 410000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
 			reg = <0x00410000 0x1000>;
 			reg-names = "ahci";
@@ -232,7 +232,7 @@
 			};
 		};
 
-		sata_phy6: sata_phy at 00412100 {
+		sata_phy6: sata_phy at 412100 {
 			compatible = "brcm,iproc-sr-sata-phy";
 			reg = <0x00412100 0x1000>;
 			reg-names = "phy";
@@ -246,7 +246,7 @@
 			};
 		};
 
-		sata7: ahci at 00420000 {
+		sata7: ahci at 420000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
 			reg = <0x00420000 0x1000>;
 			reg-names = "ahci";
@@ -262,7 +262,7 @@
 			};
 		};
 
-		sata_phy7: sata_phy at 00422100 {
+		sata_phy7: sata_phy at 422100 {
 			compatible = "brcm,iproc-sr-sata-phy";
 			reg = <0x00422100 0x1000>;
 			reg-names = "phy";
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index e6f75c633623..99aaff0b6d72 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -42,7 +42,7 @@
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		cpu at 000 {
+		cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x0 0x0>;
@@ -50,7 +50,7 @@
 			next-level-cache = <&CLUSTER0_L2>;
 		};
 
-		cpu at 001 {
+		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x0 0x1>;
@@ -106,7 +106,7 @@
 			next-level-cache = <&CLUSTER3_L2>;
 		};
 
-		CLUSTER0_L2: l2-cache at 000 {
+		CLUSTER0_L2: l2-cache at 0 {
 			compatible = "cache";
 		};
 
@@ -152,13 +152,13 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x61000000 0x05000000>;
 
-		ccn: ccn at 00000000 {
+		ccn: ccn at 0 {
 			compatible = "arm,ccn-502";
 			reg = <0x00000000 0x900000>;
 			interrupts = <GIC_SPI 799 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		gic: interrupt-controller at 02c00000 {
+		gic: interrupt-controller at 2c00000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
 			#address-cells = <1>;
@@ -177,7 +177,7 @@
 			};
 		};
 
-		smmu: mmu at 03000000 {
+		smmu: mmu at 3000000 {
 			compatible = "arm,mmu-500";
 			reg = <0x03000000 0x80000>;
 			#global-interrupts = <1>;
@@ -258,7 +258,7 @@
 
 		#include "stingray-clock.dtsi"
 
-		gpio_crmu: gpio at 00024800 {
+		gpio_crmu: gpio at 24800 {
 			compatible = "brcm,iproc-gpio";
 			reg = <0x00024800 0x4c>;
 			ngpios = <6>;
@@ -278,7 +278,7 @@
 
 		#include "stingray-pinctrl.dtsi"
 
-		mdio_mux_iproc: mdio-mux at 0002023c {
+		mdio_mux_iproc: mdio-mux at 2023c {
 			compatible = "brcm,mdio-mux-iproc";
 			reg = <0x0002023c 0x14>;
 			#address-cells = <1>;
@@ -309,7 +309,7 @@
 			};
 		};
 
-		pwm: pwm at 00010000 {
+		pwm: pwm at 10000 {
 			compatible = "brcm,iproc-pwm";
 			reg = <0x00010000 0x1000>;
 			clocks = <&crmu_ref25m>;
@@ -317,7 +317,7 @@
 			status = "disabled";
 		};
 
-		timer0: timer at 00030000 {
+		timer0: timer at 30000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x00030000 0x1000>;
 			interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
@@ -328,7 +328,7 @@
 			status = "disabled";
 		};
 
-		timer1: timer at 00040000 {
+		timer1: timer at 40000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x00040000 0x1000>;
 			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
@@ -338,7 +338,7 @@
 			clock-names = "timer1", "timer2", "apb_pclk";
 		};
 
-		timer2: timer at 00050000 {
+		timer2: timer at 50000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x00050000 0x1000>;
 			interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
@@ -349,7 +349,7 @@
 			status = "disabled";
 		};
 
-		timer3: timer at 00060000 {
+		timer3: timer at 60000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x00060000 0x1000>;
 			interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
@@ -360,7 +360,7 @@
 			status = "disabled";
 		};
 
-		timer4: timer at 00070000 {
+		timer4: timer at 70000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x00070000 0x1000>;
 			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
@@ -371,7 +371,7 @@
 			status = "disabled";
 		};
 
-		timer5: timer at 00080000 {
+		timer5: timer at 80000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x00080000 0x1000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
@@ -382,7 +382,7 @@
 			status = "disabled";
 		};
 
-		timer6: timer at 00090000 {
+		timer6: timer at 90000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x00090000 0x1000>;
 			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
@@ -393,7 +393,7 @@
 			status = "disabled";
 		};
 
-		timer7: timer at 000a0000 {
+		timer7: timer at a0000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x000a0000 0x1000>;
 			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
@@ -404,7 +404,7 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at 000b0000 {
+		i2c0: i2c at b0000 {
 			compatible = "brcm,iproc-i2c";
 			reg = <0x000b0000 0x100>;
 			#address-cells = <1>;
@@ -414,7 +414,7 @@
 			status = "disabled";
 		};
 
-		wdt0: watchdog at 000c0000 {
+		wdt0: watchdog at c0000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x000c0000 0x1000>;
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
@@ -422,7 +422,7 @@
 			clock-names = "wdogclk", "apb_pclk";
 		};
 
-		gpio_hsls: gpio at 000d0000 {
+		gpio_hsls: gpio at d0000 {
 			compatible = "brcm,iproc-gpio";
 			reg = <0x000d0000 0x864>;
 			ngpios = <151>;
@@ -448,7 +448,7 @@
 					<&pinmux 151 91 4>;
 		};
 
-		i2c1: i2c at 000e0000 {
+		i2c1: i2c at e0000 {
 			compatible = "brcm,iproc-i2c";
 			reg = <0x000e0000 0x100>;
 			#address-cells = <1>;
@@ -458,7 +458,7 @@
 			status = "disabled";
 		};
 
-		uart0: uart at 00100000 {
+		uart0: uart at 100000 {
 			device_type = "serial";
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00100000 0x1000>;
@@ -469,7 +469,7 @@
 			status = "disabled";
 		};
 
-		uart1: uart at 00110000 {
+		uart1: uart at 110000 {
 			device_type = "serial";
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00110000 0x1000>;
@@ -480,7 +480,7 @@
 			status = "disabled";
 		};
 
-		uart2: uart at 00120000 {
+		uart2: uart at 120000 {
 			device_type = "serial";
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00120000 0x1000>;
@@ -491,7 +491,7 @@
 			status = "disabled";
 		};
 
-		uart3: uart at 00130000 {
+		uart3: uart at 130000 {
 			device_type = "serial";
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00130000 0x1000>;
@@ -502,7 +502,7 @@
 			status = "disabled";
 		};
 
-		ssp0: ssp at 00180000 {
+		ssp0: ssp at 180000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x00180000 0x1000>;
 			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
@@ -514,7 +514,7 @@
 			status = "disabled";
 		};
 
-		ssp1: ssp at 00190000 {
+		ssp1: ssp at 190000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x00190000 0x1000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
@@ -526,12 +526,12 @@
 			status = "disabled";
 		};
 
-		hwrng: hwrng at 00220000 {
+		hwrng: hwrng at 220000 {
 			compatible = "brcm,iproc-rng200";
 			reg = <0x00220000 0x28>;
 		};
 
-		dma0: dma at 00310000 {
+		dma0: dma at 310000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x00310000 0x1000>;
 			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
@@ -551,7 +551,7 @@
 			iommus = <&smmu 0x6000 0x0000>;
 		};
 
-		enet: ethernet at 00340000{
+		enet: ethernet at 340000{
 			compatible = "brcm,amac";
 			reg = <0x00340000 0x1000>;
 			reg-names = "amac_base";
@@ -560,7 +560,7 @@
 			status= "disabled";
 		};
 
-		nand: nand at 00360000 {
+		nand: nand at 360000 {
 			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
 			reg = <0x00360000 0x600>,
 			      <0x0050a408 0x600>,
@@ -573,7 +573,7 @@
 			status = "disabled";
 		};
 
-		sdio0: sdhci at 003f1000 {
+		sdio0: sdhci at 3f1000 {
 			compatible = "brcm,sdhci-iproc";
 			reg = <0x003f1000 0x100>;
 			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
@@ -583,7 +583,7 @@
 			status = "disabled";
 		};
 
-		sdio1: sdhci at 003f2000 {
+		sdio1: sdhci at 3f2000 {
 			compatible = "brcm,sdhci-iproc";
 			reg = <0x003f2000 0x100>;
 			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dts b/arch/arm64/boot/dts/cavium/thunder-88xx.dts
index 800ba65991f7..5ec2bfa5f714 100644
--- a/arch/arm64/boot/dts/cavium/thunder-88xx.dts
+++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dts
@@ -60,7 +60,7 @@
 		serial1 = &uaa1;
 	};
 
-	memory at 00000000 {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x00000000 0x0 0x80000000>;
 	};
diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
index 04dc8a8d1539..1a9103b269cb 100644
--- a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
+++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
@@ -62,97 +62,97 @@
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		cpu at 000 {
+		cpu at 0 {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x000>;
 			enable-method = "psci";
 		};
-		cpu at 001 {
+		cpu at 1 {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x001>;
 			enable-method = "psci";
 		};
-		cpu at 002 {
+		cpu at 2 {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x002>;
 			enable-method = "psci";
 		};
-		cpu at 003 {
+		cpu at 3 {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x003>;
 			enable-method = "psci";
 		};
-		cpu at 004 {
+		cpu at 4 {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x004>;
 			enable-method = "psci";
 		};
-		cpu at 005 {
+		cpu at 5 {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x005>;
 			enable-method = "psci";
 		};
-		cpu at 006 {
+		cpu at 6 {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x006>;
 			enable-method = "psci";
 		};
-		cpu at 007 {
+		cpu at 7 {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x007>;
 			enable-method = "psci";
 		};
-		cpu at 008 {
+		cpu at 8 {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x008>;
 			enable-method = "psci";
 		};
-		cpu at 009 {
+		cpu at 9 {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x009>;
 			enable-method = "psci";
 		};
-		cpu at 00a {
+		cpu at a {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x00a>;
 			enable-method = "psci";
 		};
-		cpu at 00b {
+		cpu at b {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x00b>;
 			enable-method = "psci";
 		};
-		cpu at 00c {
+		cpu at c {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x00c>;
 			enable-method = "psci";
 		};
-		cpu at 00d {
+		cpu at d {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x00d>;
 			enable-method = "psci";
 		};
-		cpu at 00e {
+		cpu at e {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x00e>;
 			enable-method = "psci";
 		};
-		cpu at 00f {
+		cpu at f {
 			device_type = "cpu";
 			compatible = "cavium,thunder", "arm,armv8";
 			reg = <0x0 0x00f>;
diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
index abba750b87f8..3bbd017f088f 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
@@ -18,7 +18,7 @@
 	model = "Hisilicon Hip05 D02 Development Board";
 	compatible = "hisilicon,hip05-d02";
 
-	memory at 00000000 {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x00000000 0x0 0x80000000>;
 	};
diff --git a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
index 7c4114a67753..9af633021a42 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
@@ -17,7 +17,7 @@
 	model = "Hisilicon Hip06 D03 Development Board";
 	compatible = "hisilicon,hip06-d03";
 
-	memory at 00000000 {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x00000000 0x0 0x40000000>;
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 9c3bdf87e543..8f79e8dae102 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -56,7 +56,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory at 00000000 {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 0d7b2ae46610..46ec003eabb0 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -56,7 +56,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory at 00000000 {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index acf5c7d16d79..4fbb13d41451 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -57,7 +57,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory at 00000000 {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-8080-db.dts b/arch/arm64/boot/dts/marvell/armada-8080-db.dts
index 707af833832b..85b58a19a9fb 100644
--- a/arch/arm64/boot/dts/marvell/armada-8080-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8080-db.dts
@@ -55,7 +55,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory at 00000000 {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
index 95a1ff60f6c1..b98ea137371d 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
@@ -54,13 +54,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 000 {
+		cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x000>;
 			enable-method = "psci";
 		};
-		cpu at 001 {
+		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x001>;
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
index ba43a4357b89..116164ff260f 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
@@ -54,13 +54,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 000 {
+		cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x000>;
 			enable-method = "psci";
 		};
-		cpu at 001 {
+		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x001>;
diff --git a/arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi b/arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
index bf1b22b70384..7f0661e12f5e 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
@@ -52,13 +52,13 @@
 		#size-cells = <0>;
 		compatible = "marvell,armada-ap810-octa";
 
-		cpu at 000 {
+		cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x000>;
 			enable-method = "psci";
 		};
-		cpu at 001 {
+		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x001>;
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index d6b800fd26d0..d2f88b92d8e2 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -167,7 +167,7 @@
 			ranges = <0 0xe80000 0x10000>;
 			interrupt-parent = <&aic>;
 
-			gpio0: gpio at 0400 {
+			gpio0: gpio at 400 {
 				compatible = "snps,dw-apb-gpio";
 				reg = <0x0400 0x400>;
 				#address-cells = <1>;
@@ -185,7 +185,7 @@
 				};
 			};
 
-			gpio1: gpio at 0800 {
+			gpio1: gpio at 800 {
 				compatible = "snps,dw-apb-gpio";
 				reg = <0x0800 0x400>;
 				#address-cells = <1>;
@@ -203,7 +203,7 @@
 				};
 			};
 
-			gpio2: gpio at 0c00 {
+			gpio2: gpio at c00 {
 				compatible = "snps,dw-apb-gpio";
 				reg = <0x0c00 0x400>;
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 1d63e6b879de..d294b3de3125 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -192,7 +192,7 @@
 			};
 		};
 
-		sdhci at 07824000 {
+		sdhci at 7824000 {
 			vmmc-supply = <&pm8916_l8>;
 			vqmmc-supply = <&pm8916_l5>;
 
@@ -202,7 +202,7 @@
 			status = "okay";
 		};
 
-		sdhci at 07864000 {
+		sdhci at 7864000 {
 			vmmc-supply = <&pm8916_l11>;
 			vqmmc-supply = <&pm8916_l12>;
 
@@ -232,7 +232,7 @@
 			};
 		};
 
-		lpass at 07708000 {
+		lpass at 7708000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 789f3e87321e..b8dbb203b664 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -51,31 +51,31 @@
 			pinctrl-1 = <&blsp2_uart2_4pins_sleep>;
 		};
 
-		i2c at 07577000 {
+		i2c at 7577000 {
 		/* On Low speed expansion */
 			label = "LS-I2C0";
 			status = "okay";
 		};
 
-		i2c at 075b6000 {
+		i2c at 75b6000 {
 		/* On Low speed expansion */
 			label = "LS-I2C1";
 			status = "okay";
 		};
 
-		spi at 07575000 {
+		spi at 7575000 {
 		/* On Low speed expansion */
 			label = "LS-SPI0";
 			status = "okay";
 		};
 
-		i2c at 075b5000 {
+		i2c at 75b5000 {
 		/* On High speed expansion */
 			label = "HS-I2C2";
 			status = "okay";
 		};
 
-		spi at 075ba000{
+		spi at 75ba000{
 		/* On High speed expansion */
 			label = "HS-SPI1";
 			status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index dc3817593e14..2c4159480be2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -495,7 +495,7 @@
 			status = "disabled";
 		};
 
-		lpass: lpass at 07708000 {
+		lpass: lpass at 7708000 {
 			status = "disabled";
 			compatible = "qcom,lpass-cpu-apq8016";
 			clocks = <&gcc GCC_ULTAUDIO_AHBFABRIC_IXFABRIC_CLK>,
@@ -530,7 +530,7 @@
 			#sound-dai-cells = <1>;
                 };
 
-		sdhc_1: sdhci at 07824000 {
+		sdhc_1: sdhci at 7824000 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -547,7 +547,7 @@
 			status = "disabled";
 		};
 
-		sdhc_2: sdhci at 07864000 {
+		sdhc_2: sdhci at 7864000 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
 			reg-names = "hc_mem", "core_mem";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 887b61c872dd..b138414c248a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -395,7 +395,7 @@
 			#clock-cells = <1>;
 		};
 
-		blsp1_spi0: spi at 07575000 {
+		blsp1_spi0: spi at 7575000 {
 			compatible = "qcom,spi-qup-v2.2.1";
 			reg = <0x07575000 0x600>;
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
@@ -410,7 +410,7 @@
 			status = "disabled";
 		};
 
-		blsp2_i2c0: i2c at 075b5000 {
+		blsp2_i2c0: i2c at 75b5000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x075b5000 0x1000>;
 			interrupts = <GIC_SPI 101 0>;
@@ -441,7 +441,7 @@
 			status = "disabled";
 		};
 
-		blsp2_i2c1: i2c at 075b6000 {
+		blsp2_i2c1: i2c at 75b6000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x075b6000 0x1000>;
 			interrupts = <GIC_SPI 102 0>;
@@ -466,7 +466,7 @@
 			status = "disabled";
 		};
 
-		blsp1_i2c2: i2c at 07577000 {
+		blsp1_i2c2: i2c at 7577000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x07577000 0x1000>;
 			interrupts = <GIC_SPI 97 0>;
@@ -481,7 +481,7 @@
 			status = "disabled";
 		};
 
-		blsp2_spi5: spi at 075ba000{
+		blsp2_spi5: spi at 75ba000{
 			compatible = "qcom,spi-qup-v2.2.1";
 			reg = <0x075ba000 0x600>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
@@ -522,7 +522,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		timer at 09840000 {
+		timer at 9840000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
2.11.0
