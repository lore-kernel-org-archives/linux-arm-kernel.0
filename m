From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 22 Jun 2012 15:10:50 +0530
Subject: [PATCH 4/4] arm/dts: Add support for AM335x BeagleBone
In-Reply-To: <1340358050-29560-1-git-send-email-anilkumar@ti.com>
References: <1340358050-29560-1-git-send-email-anilkumar@ti.com>
Message-ID: <1340358050-29560-5-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AM335X BeagleBone device tree source (am335x-evm.dts) file
to use the am33xx.dtsi SoC file, along with the memory node
information.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
Reviewed-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 .../devicetree/bindings/arm/omap/omap.txt          |    3 +++
 arch/arm/boot/dts/am335x-bone.dts                  |   20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-bone.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index e78e8bc..f186167 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -47,3 +47,6 @@ Boards:
 
 - AM335X EVM : Software Developement Board for AM335x
   compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3"
+
+- AM335X Bone : Low cost community board
+  compatible = "ti,am335x-bone", "ti,am33xx", "ti,omap3"
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
new file mode 100644
index 0000000..a9af4db
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "am33xx.dtsi"
+
+/ {
+	model = "TI AM335x BeagleBone";
+	compatible = "ti,am335x-bone", "ti,am33xx";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+};
-- 
1.7.9.5
