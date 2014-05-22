From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 22 May 2014 19:44:17 +0300
Subject: [Patch v6 2/7] clock: keystone-pllctrl: add bindings for keystone pll
 controller
In-Reply-To: <1400777062-19276-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400777062-19276-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1400777062-19276-3-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main pll controller used to drive theC66x CorePacs, the switch fabric,
and a majority of the peripheral clocks (all but the ARM CorePacs, DDR3 and
the NETCP modules) requires a PLL Controller to manage the various clock
divisions, gating, and synchronization.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 .../bindings/clock/ti-keystone-pllctrl.txt           | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti-keystone-pllctrl.txt

diff --git a/Documentation/devicetree/bindings/clock/ti-keystone-pllctrl.txt b/Documentation/devicetree/bindings/clock/ti-keystone-pllctrl.txt
new file mode 100644
index 0000000..3e6a81e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti-keystone-pllctrl.txt
@@ -0,0 +1,20 @@
+* Device tree bindings for Texas Instruments keystone pll controller
+
+The main pll controller used to drive theC66x CorePacs, the switch fabric,
+and a majority of the peripheral clocks (all but the ARM CorePacs, DDR3 and
+the NETCP modules) requires a PLL Controller to manage the various clock
+divisions, gating, and synchronization.
+
+Required properties:
+
+- compatible:		"ti,keystone-pllctrl", "syscon"
+
+- reg:			contains offset/length value for pll controller
+			registers space.
+
+Example:
+
+pllctrl: pll-controller at 0x02310000 {
+	compatible = "ti,keystone-pllctrl", "syscon";
+	reg = <0x02310000 0x200>;
+};
-- 
1.8.3.2
