From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 13:53:21 +1030
Subject: [PATCH v3 13/20] ARM: dts: Add OpenBMC flash layout
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-14-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a layout used by OpenBMC systems. It describes the fixed flash
layout of a 32MB mtd device.

Reviewed-by: C?dric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3:
  - Remove leading zeros to fix warning
---
 arch/arm/boot/dts/openbmc-flash-layout.dtsi | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 arch/arm/boot/dts/openbmc-flash-layout.dtsi

diff --git a/arch/arm/boot/dts/openbmc-flash-layout.dtsi b/arch/arm/boot/dts/openbmc-flash-layout.dtsi
new file mode 100644
index 000000000000..6c26524e93e1
--- /dev/null
+++ b/arch/arm/boot/dts/openbmc-flash-layout.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	u-boot at 0 {
+		reg = <0x0 0x60000>;
+		label = "u-boot";
+	};
+
+	u-boot-env at 60000 {
+		reg = <0x60000 0x20000>;
+		label = "u-boot-env";
+	};
+
+	kernel at 80000 {
+		reg = <0x80000 0x440000>;
+		label = "kernel";
+	};
+
+	rofs at c0000 {
+		reg = <0x4c0000 0x1740000>;
+		label = "rofs";
+	};
+
+	rwfs at 1c00000 {
+		reg = <0x1c00000 0x400000>;
+		label = "rwfs";
+	};
+};
-- 
2.15.1
