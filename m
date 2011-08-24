From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 24 Aug 2011 15:09:09 +0200
Subject: [RFC PATCH 03/10] documentation/dt: Add l3-noc bindings
In-Reply-To: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314191356-10963-4-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the l3-noc bindings.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>
---
 .../devicetree/bindings/arm/omap/l3-noc.txt        |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/l3-noc.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
new file mode 100644
index 0000000..dbfa878
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
@@ -0,0 +1,18 @@
+* TI - L3 Network On Chip (NoC)
+
+This version is an implementation of the generic NoC IP
+provided by Arteris.
+
+Required properties:
+- compatible : Should be "ti,l3-noc", "arteris,noc"
+- hwmods: "l3_main_1", ... One hwmod for each noc domain.
+
+Examples:
+
+ocp {
+	compatible = "ti,l3-noc", "arteris,noc", "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+	hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
+};
-- 
1.7.0.4
