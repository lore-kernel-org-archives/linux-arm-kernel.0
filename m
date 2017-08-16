From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 16 Aug 2017 10:45:23 -0700
Subject: [PATCH 1/3] dt-bindings: mfd: d1w: iproc: Documentation for d1w driver
In-Reply-To: <1502905525-5646-1-git-send-email-scott.branden@broadcom.com>
References: <1502905525-5646-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1502905525-5646-2-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shreesha Rajashekar <shreesha@broadcom.com>

Adding document for IPROC d1w driver.

Signed-off-by: Shreesha Rajashekar <shreesha@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 .../devicetree/bindings/mfd/brcm,iproc-d1w.txt     | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/brcm,iproc-d1w.txt

diff --git a/Documentation/devicetree/bindings/mfd/brcm,iproc-d1w.txt b/Documentation/devicetree/bindings/mfd/brcm,iproc-d1w.txt
new file mode 100644
index 0000000..2bb99c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/brcm,iproc-d1w.txt
@@ -0,0 +1,27 @@
+* Broadcom Dallas One wire (D1W) bus master controller
+
+Required properties:
+- compatible : should be "brcm,iproc-d1w"
+- reg : Address and length of the register set for the device
+- interrupts : IRQ number of D1W controller
+
+Optional properties:
+- clocks : phandle of clock that supplies the module (required if platform
+		clock bindings use device tree)
+- clock-names : name for the clock
+- clock-frequency : D1W divisor clock rate
+- reset-recover-delay : Delay while reset D1W in milliseconds.
+
+Example:
+
+- From bcm-cygnus.dtsi:
+iproc_d1w: d1w at 180ab000 {
+	compatible = "brcm,iproc_d1w";
+	reg = <0x180ab000 0x0f>;
+	interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&axi81_clk>;
+	clock-names = "iproc_d1w_clk";
+	clock-frequency = <100000000>;
+	reset-recover-delay = <1>;
+};
+
-- 
2.5.0
