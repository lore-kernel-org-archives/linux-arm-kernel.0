From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Tue, 28 Aug 2018 12:29:35 +0530
Subject: [PATCH 1/2][RESEND] ARM: dts: Add big-endian in nor node for ls1021a
In-Reply-To: <20180828065936.8040-1-prabhakar.kushwaha@nxp.com>
References: <20180828065936.8040-1-prabhakar.kushwaha@nxp.com>
Message-ID: <20180828065936.8040-2-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NOR and IFC controller connectivity is big-endian.
So add big-endian field in nor device tree node allowing
IFC controller to read/write data from/to the flash correctly.

Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
---
Based on 147395ea40b36b "dt-bindings: mtd-physmap: Add endianness supports"
RESEND keeping Li Yang <leoyang.li@nxp.com> 

 arch/arm/boot/dts/ls1021a-qds.dts | 2 ++
 arch/arm/boot/dts/ls1021a-twr.dts | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 499f41a2c6f0..923a25760516 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -1,5 +1,6 @@
 /*
  * Copyright 2013-2014 Freescale Semiconductor, Inc.
+ * Copyright 2018 NXP
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -235,6 +236,7 @@
 		#size-cells = <1>;
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
+		big-endian;
 		bank-width = <2>;
 		device-width = <1>;
 	};
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index f0c949d74833..8b48c3c7cd21 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -1,5 +1,6 @@
 /*
  * Copyright 2013-2014 Freescale Semiconductor, Inc.
+ * Copyright 2018 NXP
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -203,6 +204,7 @@
 		#size-cells = <1>;
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
+		big-endian;
 		bank-width = <2>;
 		device-width = <1>;
 	};
-- 
2.14.1
