From: s-anna@ti.com (Suman Anna)
Date: Mon, 17 Jul 2017 22:28:42 -0500
Subject: [PATCH 2/4] ARM: dts: keystone-k2g: Add ti-sci power domain node
In-Reply-To: <20170718032844.29490-1-s-anna@ti.com>
References: <20170718032844.29490-1-s-anna@ti.com>
Message-ID: <20170718032844.29490-3-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Gerlach <d-gerlach@ti.com>

Add a ti-sci k2g_pds node to act as our generic power domain provider
in the system.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 7f0f4180b373..7ffd7facdc47 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -152,6 +152,11 @@
 				<&msgmgr 0 0>;
 			reg-names = "debug_messages";
 			reg = <0x02921c00 0x400>;
+
+			k2g_pds: power-controller {
+				compatible = "ti,sci-pm-domain";
+				#power-domain-cells = <1>;
+			};
 		};
 	};
 };
-- 
2.13.1
