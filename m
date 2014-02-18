From: nm@ti.com (Nishanth Menon)
Date: Tue, 18 Feb 2014 14:32:23 -0600
Subject: [RFC PATCH 6/6] devicetree: bindings: voltagedomain: add bindings for
 OMAP compatible SoCs
In-Reply-To: <1392755543-28335-1-git-send-email-nm@ti.com>
References: <1392755543-28335-1-git-send-email-nm@ti.com>
Message-ID: <1392755543-28335-7-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for device tree description for basic voltage domain
for Texas Instruments OMAP compatible SoC family of processors which
controls both bias and supply voltage planes.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../bindings/power/voltdm/voltdm_omap.txt          |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/voltdm/voltdm_omap.txt

diff --git a/Documentation/devicetree/bindings/power/voltdm/voltdm_omap.txt b/Documentation/devicetree/bindings/power/voltdm/voltdm_omap.txt
new file mode 100644
index 0000000..30cd3d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/voltdm/voltdm_omap.txt
@@ -0,0 +1,24 @@
+Texas Instruments OMAP compatible voltage domain description
+
+This binding uses [1] and describes the voltage domain devices
+typically used on Texas Instruments OMAP compatible SoC family of
+processors.
+
+[1] Documentation/devicetree/bindings/power/voltdm/voltage_domain.txt
+
+Required Properties:
+- compatible: Should be one of:
+	"ti,omap-voltdm" - basic voltage domain controlling VDD and VBB
+- vdd-supply: phandle to regulator controlling VDD supply
+- vbb-supply: phandle to regulator controlling Body Bias supply
+  (Usually Adaptive Body Bias regulator)
+- #voltdm-cells: shall be <0>
+
+Example:
+voltage_domain_mpu: voltdm at 1 {
+	compatible = "ti,omap-voltdm";
+	#voltdm-cells = <0>;
+
+	vdd-supply = <&vcc>;
+	vbb-supply = <&abb_mpu>;
+};
-- 
1.7.9.5
