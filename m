From: s-anna@ti.com (Suman Anna)
Date: Mon, 17 Jul 2017 22:28:44 -0500
Subject: [PATCH 4/4] ARM: dts: keystone-k2g: Add TI SCI reset-controller node
In-Reply-To: <20170718032844.29490-1-s-anna@ti.com>
References: <20170718032844.29490-1-s-anna@ti.com>
Message-ID: <20170718032844.29490-5-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Andrew F. Davis" <afd@ti.com>

Add a reset-controller node for managing resets of various
remote processor devices on the SoC over the Texas Instrument's
System Control Interface (TI SCI) protocol.

Signed-off-by: Andrew F. Davis <afd@ti.com>
[s-anna at ti.com: rename node name, drop obsolete header]
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 2cdc7c8aeb5c..bf4d1fa30840 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -162,6 +162,11 @@
 				compatible = "ti,k2g-sci-clk";
 				#clock-cells = <2>;
 			};
+
+			k2g_reset: reset-controller {
+				compatible = "ti,sci-reset";
+				#reset-cells = <2>;
+			};
 		};
 	};
 };
-- 
2.13.1
