From: code@mmayer.net (Markus Mayer)
Date: Mon,  5 Jun 2017 14:09:29 -0700
Subject: [PATCH 1/2] Documentation: devicetree: add binding for Broadcom STB
 AVS TMON
In-Reply-To: <20170605210930.65432-1-code@mmayer.net>
References: <20170605210930.65432-1-code@mmayer.net>
Message-ID: <20170605210930.65432-2-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Brian Norris <computersforpeace@gmail.com>

Add binding for Broadcom STB thermal.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 .../devicetree/bindings/thermal/brcm,avs-tmon.txt    | 20 ++++++++++++++++++++
 MAINTAINERS                                          |  8 ++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt

diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
new file mode 100644
index 0000000..a538a1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
@@ -0,0 +1,20 @@
+* Broadcom STB thermal management
+
+Thermal management core, provided by the AVS TMON hardware block.
+
+Required properties:
+- compatible: must be one of "brcm,avs-tmon" or "brcm,avs-tmon-bcm7445"
+- reg: address range for the AVS TMON registers
+- interrupts: temperature monitor interrupt, for high/low threshold triggers
+- interrupt-names: should be "tmon"
+- interrupt-parent: the parent interrupt controller
+
+Example:
+
+	thermal at f04d1500 {
+		compatible = "brcm,avs-tmon-bcm7445", "brcm,avs-tmon";
+		reg = <0xf04d1500 0x28>;
+		interrupts = <0x6>;
+		interrupt-names = "tmon";
+		interrupt-parent = <&avs_host_l2_intc>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index f7d568b..68ee972 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2864,6 +2864,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
 F:	drivers/cpufreq/brcmstb*
 
+BROADCOM STB AVS TMON DRIVER
+M:	Markus Mayer <mmayer@broadcom.com>
+M:	bcm-kernel-feedback-list at broadcom.com
+L:	linux-pm at vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
+F:	drivers/thermal/broadcom/brcmstb*
+
 BROADCOM SPECIFIC AMBA DRIVER (BCMA)
 M:	Rafa? Mi?ecki <zajec5@gmail.com>
 L:	linux-wireless at vger.kernel.org
-- 
2.7.4
