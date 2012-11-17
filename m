From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 17:00:45 +0100
Subject: [PATCH v2 03/14] ARM: Kirkwood: Add DTSI files for pinctrl
In-Reply-To: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
References: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353168058-14043-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a couple of different variants of Kirkwood, which differ in
the pin muxing. These DTSI files set the correct compatibility and
define commonly used groups of pins, which board dbs files can
reference.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-6281.dtsi |   39 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-6282.dtsi |   35 ++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-6281.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-6282.dtsi

diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
new file mode 100644
index 0000000..b0fe682
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
@@ -0,0 +1,39 @@
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			compatible = "marvell,88f6281-pinctrl";
+			reg = <0x10000 0x20>;
+
+			pmx_nand: pmx-nand {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
+					       "mpp4", "mpp5", "mpp18",
+					       "mpp19";
+				marvell,function = "nand";
+			};
+			pmx_sata0: pmx-sata0 {
+				marvell,pins = "mpp5", "mpp21", "mpp23";
+				marvell,function = "sata0";
+			};
+			pmx_sata1: pmx-sata1 {
+				marvell,pins = "mpp4", "mpp20", "mpp22";
+				marvell,function = "sata1";
+			};
+			pmx_spi: pmx-spi {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
+				marvell,function = "spi";
+			};
+			pmx_twsi0: pmx-twsi0 {
+				marvell,pins = "mpp8", "mpp9";
+				marvell,function = "twsi0";
+			};
+			pmx_uart0: pmx-uart0 {
+				marvell,pins = "mpp10", "mpp11";
+				marvell,function = "uart0";
+			};
+			pmx_uart1: pmx-uart1 {
+				marvell,pins = "mpp13", "mpp14";
+				marvell,function = "uart1";
+			};
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
new file mode 100644
index 0000000..d6a4145
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -0,0 +1,35 @@
+/ {
+	ocp at f1000000 {
+
+		pinctrl: pinctrl at 10000 {
+			compatible = "marvell,88f6282-pinctrl";
+			reg = <0x10000 0x20>;
+
+			pmx_sata0: pmx-sata0 {
+				marvell,pins = "mpp5", "mpp21", "mpp23";
+				marvell,function = "sata0";
+			};
+			pmx_sata1: pmx-sata1 {
+				marvell,pins = "mpp4", "mpp20", "mpp22";
+				marvell,function = "sata1";
+			};
+			pmx_spi: pmx-spi {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
+				marvell,function = "spi";
+			};
+			pmx_twsi0: pmx-twsi0 {
+				marvell,pins = "mpp8", "mpp9";
+				marvell,function = "twsi0";
+			};
+			pmx_uart0: pmx-uart0 {
+				marvell,pins = "mpp10", "mpp11";
+				marvell,function = "uart0";
+			};
+
+			pmx_uart1: pmx-uart1 {
+				marvell,pins = "mpp13", "mpp14";
+				marvell,function = "uart1";
+			};
+		};
+	};
+};
\ No newline at end of file
-- 
1.7.10.4
