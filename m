From: viresh.linux@gmail.com (Viresh Kumar)
Date: Fri, 20 Apr 2012 22:52:46 +0530
Subject: [PATCH 6/9] SPEAr13xx: Add dts and dtsi files
In-Reply-To: <cover.1334942163.git.viresh.kumar@st.com>
References: <cover.1334942163.git.viresh.kumar@st.com>
Message-ID: <928fdf1b3a9d8849a5bb32b0c79a00e8e8312087.1334942163.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds machines/boards dts{i} files for SPEAr1310 and SPEAr1340. Both
are based on ARM, Cortex A9 processor family.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/boot/dts/spear1310-evb.dts |  267 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/spear1310.dtsi    |  184 ++++++++++++++++++++++
 arch/arm/boot/dts/spear1340-evb.dts |  291 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/spear1340.dtsi    |   56 +++++++
 arch/arm/boot/dts/spear13xx.dtsi    |  258 +++++++++++++++++++++++++++++++
 5 files changed, 1056 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/spear1310-evb.dts
 create mode 100644 arch/arm/boot/dts/spear1310.dtsi
 create mode 100644 arch/arm/boot/dts/spear1340-evb.dts
 create mode 100644 arch/arm/boot/dts/spear1340.dtsi
 create mode 100644 arch/arm/boot/dts/spear13xx.dtsi

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
new file mode 100644
index 0000000..1ffc46c
--- /dev/null
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -0,0 +1,267 @@
+/*
+ * DTS file for SPEAr1310 Evaluation Baord
+ *
+ * Copyright 2012 Viresh Kumar <viresh.kumar@st.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "spear1310.dtsi"
+
+/ {
+	model = "ST SPEAr1310 Evaluation Board";
+	compatible = "st,spear1310-evb", "st,spear1310";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		reg = <0 0x40000000>;
+	};
+
+	ahb {
+		pinmux at e0700000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&state_default>;
+
+			state_default: pinmux {
+				i2c0-pmx {
+					st,pins = "i2c0_grp";
+					st,function = "i2c0";
+				};
+				i2s1 {
+					st,pins = "i2s1_grp";
+					st,function = "i2s1";
+				};
+				gpio {
+					st,pins = "arm_gpio_grp";
+					st,function = "arm_gpio";
+				};
+				eth {
+					st,pins = "gmii_grp";
+					st,function = "gmii";
+				};
+				ssp0 {
+					st,pins = "ssp0_grp";
+					st,function = "ssp0";
+				};
+				kbd {
+					st,pins = "keyboard_6x6_grp";
+					st,function = "keyboard";
+				};
+				sdhci {
+					st,pins = "sdhci_grp";
+					st,function = "sdhci";
+				};
+				smi-pmx {
+					st,pins = "smi_2_chips_grp";
+					st,function = "smi";
+				};
+				uart0 {
+					st,pins = "uart0_grp";
+					st,function = "uart0";
+				};
+				rs485 {
+					st,pins = "rs485_0_1_tdm_0_1_grp";
+					st,function = "rs485_0_1_tdm_0_1";
+				};
+				i2c1_2 {
+					st,pins = "i2c_1_2_grp";
+					st,function = "i2c_1_2";
+				};
+				pci {
+					st,pins = "pcie0_grp","pcie1_grp",
+						"pcie2_grp";
+					st,function = "pci";
+				};
+				smii {
+					st,pins = "smii_0_1_2_grp";
+					st,function = "smii_0_1_2";
+				};
+				nand {
+					st,pins = "nand_8bit_grp",
+						"nand_16bit_grp";
+					st,function = "nand";
+				};
+			};
+		};
+
+		ahci at b1000000 {
+			status = "okay";
+		};
+
+		cf at b2800000 {
+			status = "okay";
+		};
+
+		dma at ea800000 {
+			status = "okay";
+		};
+
+		dma at eb000000 {
+			status = "okay";
+		};
+
+		fsmc: flash at b0000000 {
+			status = "okay";
+		};
+
+		gmac0: eth at e2000000 {
+			status = "okay";
+		};
+
+		sdhci at b3000000 {
+			status = "okay";
+		};
+
+		smi: flash at ea000000 {
+			status = "okay";
+		};
+
+		spi0: spi at e0100000 {
+			status = "okay";
+		};
+
+		ehci at e4800000 {
+			status = "okay";
+		};
+
+		ehci at e5800000 {
+			status = "okay";
+		};
+
+		ohci at e4000000 {
+			status = "okay";
+		};
+
+		ohci at e5000000 {
+			status = "okay";
+		};
+
+		apb {
+			adc at e0080000 {
+				status = "okay";
+			};
+
+			gpio0: gpio at e0600000 {
+			       status = "okay";
+			};
+
+			gpio1: gpio at e0680000 {
+			       status = "okay";
+			};
+
+			i2c0: i2c at e0280000 {
+			       status = "okay";
+			};
+
+			i2c1: i2c at 5cd00000 {
+			       status = "okay";
+			};
+
+			kbd at e0300000 {
+				linux,keymap = < 0x00000001
+						 0x00010002
+						 0x00020003
+						 0x00030004
+						 0x00040005
+						 0x00050006
+						 0x00060007
+						 0x00070008
+						 0x00080009
+						 0x0100000a
+						 0x0101000c
+						 0x0102000d
+						 0x0103000e
+						 0x0104000f
+						 0x01050010
+						 0x01060011
+						 0x01070012
+						 0x01080013
+						 0x02000014
+						 0x02010015
+						 0x02020016
+						 0x02030017
+						 0x02040018
+						 0x02050019
+						 0x0206001a
+						 0x0207001b
+						 0x0208001c
+						 0x0300001d
+						 0x0301001e
+						 0x0302001f
+						 0x03030020
+						 0x03040021
+						 0x03050022
+						 0x03060023
+						 0x03070024
+						 0x03080025
+						 0x04000026
+						 0x04010027
+						 0x04020028
+						 0x04030029
+						 0x0404002a
+						 0x0405002b
+						 0x0406002c
+						 0x0407002d
+						 0x0408002e
+						 0x0500002f
+						 0x05010030
+						 0x05020031
+						 0x05030032
+						 0x05040033
+						 0x05050034
+						 0x05060035
+						 0x05070036
+						 0x05080037
+						 0x06000038
+						 0x06010039
+						 0x0602003a
+						 0x0603003b
+						 0x0604003c
+						 0x0605003d
+						 0x0606003e
+						 0x0607003f
+						 0x06080040
+						 0x07000041
+						 0x07010042
+						 0x07020043
+						 0x07030044
+						 0x07040045
+						 0x07050046
+						 0x07060047
+						 0x07070048
+						 0x07080049
+						 0x0800004a
+						 0x0801004b
+						 0x0802004c
+						 0x0803004d
+						 0x0804004e
+						 0x0805004f
+						 0x08060050
+						 0x08070051
+						 0x08080052 >;
+			       autorepeat;
+			       st,mode = <0>;
+			       status = "okay";
+			};
+
+			rtc at e0580000 {
+			       status = "okay";
+			};
+
+			serial at e0000000 {
+			       status = "okay";
+			};
+
+			wdt at ec800620 {
+			       status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
new file mode 100644
index 0000000..9e61da4
--- /dev/null
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -0,0 +1,184 @@
+/*
+ * DTS file for all SPEAr1310 SoCs
+ *
+ * Copyright 2012 Viresh Kumar <viresh.kumar@st.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "spear13xx.dtsi"
+
+/ {
+	compatible = "st,spear1310";
+
+	ahb {
+		ahci at b1000000 {
+			compatible = "snps,spear-ahci";
+			reg = <0xb1000000 0x10000>;
+			interrupts = <0 68 0x4>;
+			status = "disabled";
+		};
+
+		ahci at b1800000 {
+			compatible = "snps,spear-ahci";
+			reg = <0xb1800000 0x10000>;
+			interrupts = <0 69 0x4>;
+			status = "disabled";
+		};
+
+		ahci at b4000000 {
+			compatible = "snps,spear-ahci";
+			reg = <0xb4000000 0x10000>;
+			interrupts = <0 70 0x4>;
+			status = "disabled";
+		};
+
+		gmac1: eth at 5c400000 {
+			compatible = "st,spear600-gmac";
+			reg = <0x5c400000 0x8000>;
+			interrupts = <0 95 0x4>;
+			interrupt-names = "macirq";
+			status = "disabled";
+		};
+
+		gmac2: eth at 5c500000 {
+			compatible = "st,spear600-gmac";
+			reg = <0x5c500000 0x8000>;
+			interrupts = <0 96 0x4>;
+			interrupt-names = "macirq";
+			status = "disabled";
+		};
+
+		gmac3: eth at 5c600000 {
+			compatible = "st,spear600-gmac";
+			reg = <0x5c600000 0x8000>;
+			interrupts = <0 97 0x4>;
+			interrupt-names = "macirq";
+			status = "disabled";
+		};
+
+		gmac4: eth at 5c700000 {
+			compatible = "st,spear600-gmac";
+			reg = <0x5c700000 0x8000>;
+			interrupts = <0 98 0x4>;
+			interrupt-names = "macirq";
+			status = "disabled";
+		};
+
+		spi1: spi at 5d400000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x5d400000 0x1000>;
+			interrupts = <0 99 0x4>;
+			status = "disabled";
+		};
+
+		apb {
+			i2c1: i2c at 5cd00000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,designware-i2c";
+				reg = <0x5cd00000 0x1000>;
+				interrupts = <0 87 0x4>;
+				status = "disabled";
+			};
+
+			i2c2: i2c at 5ce00000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,designware-i2c";
+				reg = <0x5ce00000 0x1000>;
+				interrupts = <0 88 0x4>;
+				status = "disabled";
+			};
+
+			i2c3: i2c at 5cf00000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,designware-i2c";
+				reg = <0x5cf00000 0x1000>;
+				interrupts = <0 89 0x4>;
+				status = "disabled";
+			};
+
+			i2c4: i2c at 5d000000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,designware-i2c";
+				reg = <0x5d000000 0x1000>;
+				interrupts = <0 90 0x4>;
+				status = "disabled";
+			};
+
+			i2c5: i2c at 5d100000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,designware-i2c";
+				reg = <0x5d100000 0x1000>;
+				interrupts = <0 91 0x4>;
+				status = "disabled";
+			};
+
+			i2c6: i2c at 5d200000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,designware-i2c";
+				reg = <0x5d200000 0x1000>;
+				interrupts = <0 92 0x4>;
+				status = "disabled";
+			};
+
+			i2c7: i2c at 5d300000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,designware-i2c";
+				reg = <0x5d300000 0x1000>;
+				interrupts = <0 93 0x4>;
+				status = "disabled";
+			};
+
+			serial at 5c800000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x5c800000 0x1000>;
+				interrupts = <0 82 0x4>;
+				status = "disabled";
+			};
+
+			serial at 5c900000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x5c900000 0x1000>;
+				interrupts = <0 83 0x4>;
+				status = "disabled";
+			};
+
+			serial at 5ca00000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x5ca00000 0x1000>;
+				interrupts = <0 84 0x4>;
+				status = "disabled";
+			};
+
+			serial at 5cb00000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x5cb00000 0x1000>;
+				interrupts = <0 85 0x4>;
+				status = "disabled";
+			};
+
+			serial at 5cc00000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x5cc00000 0x1000>;
+				interrupts = <0 86 0x4>;
+				status = "disabled";
+			};
+
+			thermal at e07008c4 {
+				st,thermal-flags = <0x7000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
new file mode 100644
index 0000000..5621df3
--- /dev/null
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -0,0 +1,291 @@
+/*
+ * DTS file for SPEAr1340 Evaluation Baord
+ *
+ * Copyright 2012 Viresh Kumar <viresh.kumar@st.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "spear1340.dtsi"
+
+/ {
+	model = "ST SPEAr1340 Evaluation Board";
+	compatible = "st,spear1340-evb", "st,spear1340";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		reg = <0 0x40000000>;
+	};
+
+	ahb {
+		pinmux at e0700000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&state_default>;
+
+			state_default: pinmux {
+				pads_as_gpio {
+					st,pins = "pads_as_gpio_grp";
+					st,function = "pads_as_gpio";
+				};
+				fsmc {
+					st,pins = "fsmc_8bit_grp";
+					st,function = "fsmc";
+				};
+				kbd {
+					st,pins = "keyboard_row_col_grp",
+						"keyboard_col5_grp";
+					st,function = "keyboard";
+				};
+				uart0 {
+					st,pins = "uart0_grp", "uart0_enh_grp";
+					st,function = "uart0";
+				};
+				i2c0-pmx {
+					st,pins = "i2c0_grp";
+					st,function = "i2c0";
+				};
+				i2c1-pmx {
+					st,pins = "i2c1_grp";
+					st,function = "i2c1";
+				};
+				spdif-in {
+					st,pins = "spdif_in_grp";
+					st,function = "spdif_in";
+				};
+				spdif-out {
+					st,pins = "spdif_out_grp";
+					st,function = "spdif_out";
+				};
+				ssp0 {
+					st,pins = "ssp0_grp", "ssp0_cs1_grp",
+						"ssp0_cs3_grp";
+					st,function = "ssp0";
+				};
+				pwm {
+					st,pins = "pwm2_grp", "pwm3_grp";
+					st,function = "pwm";
+				};
+				smi-pmx {
+					st,pins = "smi_grp";
+					st,function = "smi";
+				};
+				i2s {
+					st,pins = "i2s_in_grp", "i2s_out_grp";
+					st,function = "i2s";
+				};
+				gmac {
+					st,pins = "gmii_grp", "rgmii_grp";
+					st,function = "gmac";
+				};
+				cam3 {
+					st,pins = "cam3_grp";
+					st,function = "cam3";
+				};
+				cec0 {
+					st,pins = "cec0_grp";
+					st,function = "cec0";
+				};
+				cec1 {
+					st,pins = "cec1_grp";
+					st,function = "cec1";
+				};
+				sdhci {
+					st,pins = "sdhci_grp";
+					st,function = "sdhci";
+				};
+				clcd {
+					st,pins = "clcd_grp";
+					st,function = "clcd";
+				};
+				sata {
+					st,pins = "sata_grp";
+					st,function = "sata";
+				};
+			};
+		};
+
+		ahci at b1000000 {
+			status = "okay";
+		};
+
+		cf at b2800000 {
+			status = "okay";
+		};
+
+		dma at ea800000 {
+			status = "okay";
+		};
+
+		dma at eb000000 {
+			status = "okay";
+		};
+
+		fsmc: flash at b0000000 {
+			status = "okay";
+		};
+
+		gmac0: eth at e2000000 {
+			status = "okay";
+		};
+
+		sdhci at b3000000 {
+			status = "okay";
+		};
+
+		smi: flash at ea000000 {
+			status = "okay";
+		};
+
+		spi0: spi at e0100000 {
+			status = "okay";
+		};
+
+		ehci at e4800000 {
+			status = "okay";
+		};
+
+		ehci at e5800000 {
+			status = "okay";
+		};
+
+		ohci at e4000000 {
+			status = "okay";
+		};
+
+		ohci at e5000000 {
+			status = "okay";
+		};
+
+		apb {
+			adc at e0080000 {
+				status = "okay";
+			};
+
+			gpio0: gpio at e0600000 {
+			       status = "okay";
+			};
+
+			gpio1: gpio at e0680000 {
+			       status = "okay";
+			};
+
+			i2c0: i2c at e0280000 {
+			       status = "okay";
+			};
+
+			i2c1: i2c at b4000000 {
+			       status = "okay";
+			};
+
+			kbd at e0300000 {
+				linux,keymap = < 0x00000001
+						 0x00010002
+						 0x00020003
+						 0x00030004
+						 0x00040005
+						 0x00050006
+						 0x00060007
+						 0x00070008
+						 0x00080009
+						 0x0100000a
+						 0x0101000c
+						 0x0102000d
+						 0x0103000e
+						 0x0104000f
+						 0x01050010
+						 0x01060011
+						 0x01070012
+						 0x01080013
+						 0x02000014
+						 0x02010015
+						 0x02020016
+						 0x02030017
+						 0x02040018
+						 0x02050019
+						 0x0206001a
+						 0x0207001b
+						 0x0208001c
+						 0x0300001d
+						 0x0301001e
+						 0x0302001f
+						 0x03030020
+						 0x03040021
+						 0x03050022
+						 0x03060023
+						 0x03070024
+						 0x03080025
+						 0x04000026
+						 0x04010027
+						 0x04020028
+						 0x04030029
+						 0x0404002a
+						 0x0405002b
+						 0x0406002c
+						 0x0407002d
+						 0x0408002e
+						 0x0500002f
+						 0x05010030
+						 0x05020031
+						 0x05030032
+						 0x05040033
+						 0x05050034
+						 0x05060035
+						 0x05070036
+						 0x05080037
+						 0x06000038
+						 0x06010039
+						 0x0602003a
+						 0x0603003b
+						 0x0604003c
+						 0x0605003d
+						 0x0606003e
+						 0x0607003f
+						 0x06080040
+						 0x07000041
+						 0x07010042
+						 0x07020043
+						 0x07030044
+						 0x07040045
+						 0x07050046
+						 0x07060047
+						 0x07070048
+						 0x07080049
+						 0x0800004a
+						 0x0801004b
+						 0x0802004c
+						 0x0803004d
+						 0x0804004e
+						 0x0805004f
+						 0x08060050
+						 0x08070051
+						 0x08080052 >;
+			       autorepeat;
+			       st,mode = <0>;
+			       status = "okay";
+			};
+
+			rtc at e0580000 {
+			       status = "okay";
+			};
+
+			serial at e0000000 {
+			       status = "okay";
+			};
+
+			serial at b4100000 {
+			       status = "okay";
+			};
+
+			wdt at ec800620 {
+			       status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
new file mode 100644
index 0000000..a26fc47
--- /dev/null
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -0,0 +1,56 @@
+/*
+ * DTS file for all SPEAr1340 SoCs
+ *
+ * Copyright 2012 Viresh Kumar <viresh.kumar@st.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "spear13xx.dtsi"
+
+/ {
+	compatible = "st,spear1340";
+
+	ahb {
+		ahci at b1000000 {
+			compatible = "snps,spear-ahci";
+			reg = <0xb1000000 0x10000>;
+			interrupts = <0 72 0x4>;
+			status = "disabled";
+		};
+
+		spi1: spi at 5d400000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x5d400000 0x1000>;
+			interrupts = <0 99 0x4>;
+			status = "disabled";
+		};
+
+		apb {
+			i2c1: i2c at b4000000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,designware-i2c";
+				reg = <0xb4000000 0x1000>;
+				interrupts = <0 104 0x4>;
+				status = "disabled";
+			};
+
+			serial at b4100000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xb4100000 0x1000>;
+				interrupts = <0 105 0x4>;
+				status = "disabled";
+			};
+
+			thermal at e07008c4 {
+				st,thermal-flags = <0x2a00>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
new file mode 100644
index 0000000..a9d1872
--- /dev/null
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -0,0 +1,258 @@
+/*
+ * DTS file for all SPEAr13xx SoCs
+ *
+ * Copyright 2012 Viresh Kumar <viresh.kumar@st.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	gic: interrupt-controller at ec801000 {
+		compatible = "arm,cortex-a9-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = < 0xec801000 0x1000 >,
+		      < 0xec800100 0x0100 >;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 8 0x04
+			      0 9 0x04>;
+	};
+
+	L2: l2-cache {
+		    compatible = "arm,pl310-cache";
+		    reg = <0xed000000 0x1000>;
+		    cache-unified;
+		    cache-level = <2>;
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0 0x40000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyAMA0,115200";
+	};
+
+	ahb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <0x50000000 0x50000000 0x10000000
+			  0xb0000000 0xb0000000 0x10000000
+			  0xe0000000 0xe0000000 0x10000000>;
+
+		sdhci at b3000000 {
+			compatible = "st,sdhci-spear";
+			reg = <0xb3000000 0x100>;
+			interrupts = <0 28 0x4>;
+			status = "disabled";
+		};
+
+		cf at b2800000 {
+			compatible = "arasan,cf-spear1340";
+			reg = <0xb2800000 0x100>;
+			interrupts = <0 29 0x4>;
+			status = "disabled";
+		};
+
+		dma at ea800000 {
+			compatible = "snps,dma-spear1340";
+			reg = <0xea800000 0x1000>;
+			interrupts = <0 19 0x4>;
+			status = "disabled";
+		};
+
+		dma at eb000000 {
+			compatible = "snps,dma-spear1340";
+			reg = <0xeb000000 0x1000>;
+			interrupts = <0 59 0x4>;
+			status = "disabled";
+		};
+
+		fsmc: flash at b0000000 {
+			compatible = "st,spear600-fsmc-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xb0000000 0x1000	/* FSMC Register */
+			       0xb0800000 0x0010>;	/* NAND Base */
+			reg-names = "fsmc_regs", "nand_data";
+			interrupts = <0 20 0x4
+				      0 21 0x4
+				      0 22 0x4
+				      0 23 0x4>;
+			st,ale-off = <0x20000>;
+			st,cle-off = <0x10000>;
+			status = "disabled";
+		};
+
+		gmac0: eth at e2000000 {
+			compatible = "st,spear600-gmac";
+			reg = <0xe2000000 0x8000>;
+			interrupts = <0 23 0x4
+				      0 24 0x4>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			status = "disabled";
+		};
+
+		smi: flash at ea000000 {
+			compatible = "st,spear600-smi";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xea000000 0x1000>;
+			interrupts = <0 30 0x4>;
+			status = "disabled";
+		};
+
+		spi0: spi at e0100000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0xe0100000 0x1000>;
+			interrupts = <0 31 0x4>;
+			status = "disabled";
+		};
+
+		ehci at e4800000 {
+			compatible = "st,spear600-ehci", "usb-ehci";
+			reg = <0xe4800000 0x1000>;
+			interrupts = <0 64 0x4>;
+			status = "disabled";
+		};
+
+		ehci at e5800000 {
+			compatible = "st,spear600-ehci", "usb-ehci";
+			reg = <0xe5800000 0x1000>;
+			interrupts = <0 66 0x4>;
+			status = "disabled";
+		};
+
+		ohci at e4000000 {
+			compatible = "st,spear600-ohci", "usb-ohci";
+			reg = <0xe4000000 0x1000>;
+			interrupts = <0 65 0x4>;
+			status = "disabled";
+		};
+
+		ohci at e5000000 {
+			compatible = "st,spear600-ohci", "usb-ohci";
+			reg = <0xe5000000 0x1000>;
+			interrupts = <0 67 0x4>;
+			status = "disabled";
+		};
+
+		apb {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges = <0x50000000 0x50000000 0x10000000
+				  0xb0000000 0xb0000000 0x10000000
+				  0xe0000000 0xe0000000 0x10000000>;
+
+			gpio0: gpio at e0600000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xe0600000 0x1000>;
+				interrupts = <0 24 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio1: gpio at e0680000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xe0680000 0x1000>;
+				interrupts = <0 25 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			kbd at e0300000 {
+				compatible = "st,spear300-kbd";
+				reg = <0xe0300000 0x1000>;
+				interrupts = <0 52 0x4>;
+				status = "disabled";
+			};
+
+			i2c0: i2c at e0280000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,designware-i2c";
+				reg = <0xe0280000 0x1000>;
+				interrupts = <0 41 0x4>;
+				status = "disabled";
+			};
+
+			rtc at e0580000 {
+				compatible = "st,spear-rtc";
+				reg = <0xe0580000 0x1000>;
+				interrupts = <0 36 0x4>;
+				status = "disabled";
+			};
+
+			serial at e0000000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xe0000000 0x1000>;
+				interrupts = <0 36 0x4>;
+				status = "disabled";
+			};
+
+			adc at e0080000 {
+				compatible = "st,spear600-adc";
+				reg = <0xe0080000 0x1000>;
+				interrupts = <0 44 0x4>;
+				status = "disabled";
+			};
+
+			timer at ec800600 {
+				compatible = "arm,cortex-a9-twd-timer";
+				reg = <0xec800620 0x20>;
+				interrupts = <1 13 0x301>;
+			};
+
+			wdt at ec800620 {
+				compatible = "arm,mpcore-wdt";
+				reg = <0xec800620 0x1000>;
+				interrupts = <1 14 0x301>;
+				status = "disabled";
+			};
+
+			thermal at e07008c4 {
+				compatible = "st,thermal-spear1340";
+				reg = <0xe07008c4 0x4>;
+			};
+		};
+	};
+};
-- 
1.7.9
