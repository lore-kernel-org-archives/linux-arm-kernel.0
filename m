From: carlo@caione.org (Carlo Caione)
Date: Fri, 14 Nov 2014 17:25:51 +0100
Subject: [PATCH RESEND 1/3] ARM: Meson6: docs: document bindings
In-Reply-To: <1415982353-9293-1-git-send-email-carlo@caione.org>
References: <1415982353-9293-1-git-send-email-carlo@caione.org>
Message-ID: <1415982353-9293-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation for the devicetree bindings introduced with the SMP support

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 .../bindings/arm/meson/amlogic,meson6-cpuconfig    | 16 +++++++++++++
 .../bindings/arm/meson/amlogic,meson6-smp          | 26 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/meson/amlogic,meson6-cpuconfig
 create mode 100644 Documentation/devicetree/bindings/arm/meson/amlogic,meson6-smp

diff --git a/Documentation/devicetree/bindings/arm/meson/amlogic,meson6-cpuconfig b/Documentation/devicetree/bindings/arm/meson/amlogic,meson6-cpuconfig
new file mode 100644
index 0000000..2db4cbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/meson/amlogic,meson6-cpuconfig
@@ -0,0 +1,16 @@
+Secondary CPU management unit:
+-------------------------------
+
+This document describes the "amlogic,meson6-cpuconfig" node for enabling the
+secondary CPU.
+
+Required node properties:
+- compatible value : = "amlogic,meson6-cpuconfig";
+- reg : physical base address and the size of the registers window
+
+Example:
+
+	cpuconfig at d901ff80 {
+		compatible = "amlogic,meson6-cpuconfig";
+		reg = <0xd901ff80 0x8>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/meson/amlogic,meson6-smp b/Documentation/devicetree/bindings/arm/meson/amlogic,meson6-smp
new file mode 100644
index 0000000..4130381
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/meson/amlogic,meson6-smp
@@ -0,0 +1,26 @@
+Secondary CPU enable-method "amlogic,meson6-smp" binding:
+----------------------------------------------------------
+
+This document describes the "amlogic,meson6-smp" method for enabling secondary
+CPUs. To apply to all CPUs, a single "amlogic,meson6-smp" enable method should
+be defined in the "cpus" node.
+
+Example:
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "amlogic,meson6-smp";
+
+		cpu at 200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x200>;
+		};
+
+		cpu at 201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x201>;
+		};
+	};
-- 
1.9.1
