From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 22 Oct 2014 13:57:49 -0700
Subject: [PATCH v7 2/7] dt-bindings: Document Broadcom Cygnus SoC and clocks
In-Reply-To: <1414011474-11821-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1414011474-11821-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1414011474-11821-3-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Richardson <jonathar@broadcom.com>

Reviewed-by: Arun Parameswaran <aparames@broadcom.com>
Tested-by: Jonathan Richardson <jonathar@broadcom.com>
Reviewed-by: JD (Jiandong) Zheng <jdzheng@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 .../devicetree/bindings/arm/bcm/cygnus.txt         |   31 ++++++++++++++++++
 .../devicetree/bindings/clock/bcm-cygnus-clock.txt |   34 ++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/cygnus.txt b/Documentation/devicetree/bindings/arm/bcm/cygnus.txt
new file mode 100644
index 0000000..4c77169
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/cygnus.txt
@@ -0,0 +1,31 @@
+Broadcom Cygnus device tree bindings
+------------------------------------
+
+
+Boards with Cygnus SoCs shall have the following properties:
+
+Required root node property:
+
+BCM11300
+compatible = "brcm,bcm11300", "brcm,cygnus";
+
+BCM11320
+compatible = "brcm,bcm11320", "brcm,cygnus";
+
+BCM11350
+compatible = "brcm,bcm11350", "brcm,cygnus";
+
+BCM11360
+compatible = "brcm,bcm11360", "brcm,cygnus";
+
+BCM58300
+compatible = "brcm,bcm58300", "brcm,cygnus";
+
+BCM58302
+compatible = "brcm,bcm58302", "brcm,cygnus";
+
+BCM58303
+compatible = "brcm,bcm58303", "brcm,cygnus";
+
+BCM58305
+compatible = "brcm,bcm58305", "brcm,cygnus";
diff --git a/Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt b/Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt
new file mode 100644
index 0000000..00d26ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt
@@ -0,0 +1,34 @@
+Broadcom Cygnus Clocks
+
+This binding uses the common clock binding:
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Currently various "fixed" clocks are declared for peripheral drivers that use
+the common clock framework to reference their core clocks. Proper support of
+these clocks will be added later
+
+Device tree example:
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		osc: oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <1>;
+			clock-frequency = <25000000>;
+		};
+
+		apb_clk: apb_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1000000000>;
+		};
+
+		periph_clk: periph_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <500000000>;
+		};
+	};
-- 
1.7.9.5
