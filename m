From: s-anna@ti.com (Suman Anna)
Date: Mon, 17 Jul 2017 22:28:43 -0500
Subject: [PATCH 3/4] ARM: dts: keystone-k2g: Add ti-sci clock provider node
In-Reply-To: <20170718032844.29490-1-s-anna@ti.com>
References: <20170718032844.29490-1-s-anna@ti.com>
Message-ID: <20170718032844.29490-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <t-kristo@ti.com>

Add a ti-sci node representing the clock provider in the system.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 7ffd7facdc47..2cdc7c8aeb5c 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -157,6 +157,11 @@
 				compatible = "ti,sci-pm-domain";
 				#power-domain-cells = <1>;
 			};
+
+			k2g_clks: clocks {
+				compatible = "ti,k2g-sci-clk";
+				#clock-cells = <2>;
+			};
 		};
 	};
 };
-- 
2.13.1
