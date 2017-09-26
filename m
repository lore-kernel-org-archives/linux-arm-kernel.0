From: code@mmayer.net (Markus Mayer)
Date: Tue, 26 Sep 2017 14:27:58 -0700
Subject: [PATCH v5 1/2] Documentation: devicetree: add binding for Broadcom
 STB AVS TMON
In-Reply-To: <20170926212800.4879-1-code@mmayer.net>
References: <20170926212800.4879-1-code@mmayer.net>
Message-ID: <20170926212800.4879-2-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Brian Norris <computersforpeace@gmail.com>

Add binding for Broadcom STB thermal.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 .../devicetree/bindings/thermal/brcm,avs-tmon.txt    | 20 ++++++++++++++++++++
 MAINTAINERS                                          |  8 ++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt

diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
new file mode 100644
index 0000000..9d43553
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
@@ -0,0 +1,20 @@
+* Broadcom STB thermal management
+
+Thermal management core, provided by the AVS TMON hardware block.
+
+Required properties:
+- compatible: must be "brcm,avs-tmon" and/or "brcm,avs-tmon-bcm7445"
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
index 2281af4..46c592b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2955,6 +2955,14 @@ S:	Maintained
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
 BROADCOM STB NAND FLASH DRIVER
 M:	Brian Norris <computersforpeace@gmail.com>
 M:	Kamal Dasu <kdasu.kdev@gmail.com>
-- 
2.7.4
