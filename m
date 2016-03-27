From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 27 Mar 2016 11:26:14 +0200
Subject: [PATCH v4 2/5] dt-bindings: arm: add DT binding for Marvell AP806
 system controller
In-Reply-To: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1459070777-18049-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the Device Tree binding documentation for the system
controller found in Marvell AP806 HW block, which is one of the core
HW blocks of the 64-bits Marvell Armada 7K/8K family.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../arm/marvell/ap806-system-controller.txt        | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
new file mode 100644
index 0000000..8968371
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -0,0 +1,35 @@
+Marvell Armada AP806 System Controller
+======================================
+
+The AP806 is one of the two core HW blocks of the Marvell Armada 7K/8K
+SoCs. It contains a system controller, which provides a number
+registers giving access to numerous features: clocks, pin-muxing and
+many other SoC configuration items. This DT binding allows to describe
+this system controller.
+
+The Device Tree node representing the AP806 system controller provides
+a number of clocks:
+
+ - 0: clock of CPU cluster 0
+ - 1: clock of CPU cluster 1
+ - 2: fixed PLL at 1200 Mhz
+ - 3: MSS clock, derived from the fixed PLL
+
+Required properties:
+
+ - compatible: must be:
+     "marvell,ap806-system-controller", "syscon"
+ - reg: register area of the AP806 system controller
+ - #clock-cells: must be set to 1
+ - clock-output-names: must be defined to:
+    "ap-cpu-cluster-0", "ap-cpu-cluster-1", "ap-fixed", "ap-mss"
+
+Example:
+
+	syscon: system-controller at 6f4000 {
+		compatible = "marvell,ap806-system-controller", "syscon";
+		#clock-cells = <1>;
+		clock-output-names = "ap-cpu-cluster-0", "ap-cpu-cluster-1",
+				     "ap-fixed", "ap-mss";
+		reg = <0x6f4000 0x1000>;
+	};
-- 
2.6.4
