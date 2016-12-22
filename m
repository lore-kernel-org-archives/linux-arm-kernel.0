From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 22 Dec 2016 18:24:56 +0100
Subject: [PATCH 1/6] pinctrl: dt-bindings: Add documentation for Armada 37xx
 pin controllers
In-Reply-To: <20161222172501.16121-1-gregory.clement@free-electrons.com>
References: <20161222172501.16121-1-gregory.clement@free-electrons.com>
Message-ID: <20161222172501.16121-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device tree binding for the pin controllers found on the
Armada 37xx SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../pinctrl/marvell,armada-37xx-pinctrl.txt        | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
new file mode 100644
index 000000000000..53a30a09d3fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
@@ -0,0 +1,127 @@
+* Marvell Armada 37xx SoC pinctrl
+
+Refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning
+of the phrase "pin configuration node".
+
+Each Armada 37xx SoC come with two pin controller one for the south
+bridge and the other for the north bridge.
+
+Required properties for pinctrl driver:
+- compatible:	"marvell,armada3710-sb-pinctrl" for the south bridge
+		"marvell,armada3710-nb-pinctrl" for the north bridge
+- reg: The first set of register are for pinctrl/gpio and the second
+  set for the interrupt controller
+- interrupts: list of the interrupt use by the gpio
+
+Available groups and functions for the North bridge:
+
+group: jtag
+ - pins 20-24
+ - functions jtag, gpio
+
+group sdio0
+ - pins 8-10
+ - functions sdio, gpio
+
+group emmc_nb
+ - pins 27-35
+ - functions emmc, gpio
+
+group pwm0
+ - pin 11 (GPIO1-11)
+ - functions pwm, gpio
+
+group pwm1
+ - pin 12
+ - functions pwm, gpio
+
+group pwm2
+ - pin 13
+ - functions pwm, gpio
+
+group pwm3
+ - pin 14
+ - functions pwm, gpio
+
+group pmic1
+ - pin 17
+ - functions pmic, gpio
+
+group pmic0
+ - pin 16
+ - functions pmic, gpio
+
+group i2c2
+ - pins 2-3
+ - functions i2c, gpio
+
+group i2c1
+ - pins 0-1
+ - functions i2c, gpio
+
+group spi_cs1
+ - pin 17
+ - functions spi, gpio
+
+group spi_cs2
+ - pin 18
+ - functions spi, gpio
+
+group spi_cs3
+ - pin 19
+ - functions spi, gpio
+
+group onewire
+ - pin 4
+ - functions onewire, gpio
+
+group uart1
+ - pins 25-26
+ - functions uart, gpio
+
+group spi_quad
+ - pins 15-16
+ - functions spi, gpio
+
+group uart_2
+ - pins 9-10
+ - functions uart, gpio
+
+Available groups and functions for the South bridge:
+
+group usb32_drvvbus0
+ - pin 36
+ - functions drvbus, gpio
+
+group usb2_drvvbus1
+ - pin 37
+ - functions drvbus, gpio
+
+group sdio_sb
+ - pins 60-64
+ - functions sdio, gpio
+
+group rgmii
+ - pins 42-55
+ - functions mii, gpio
+
+group pcie1
+ - pins 39-40
+ - functions pcie, gpio
+
+group ptp
+ - pins 56-58
+ - functions ptp, gpio
+
+group ptp_clk
+ - pin 57
+ - functions ptp, mii
+
+group ptp_trig
+ - pin 58
+ - functions ptp, mii
+
+group mii_col
+ - pin 59
+ - functions mii, mii_err
-- 
2.11.0
