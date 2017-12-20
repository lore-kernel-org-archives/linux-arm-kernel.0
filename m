From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 13:53:27 +1030
Subject: [PATCH v3 19/20] ARM: dts: aspeed-plametto: Add flash layout and fix
 memory node
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-20-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OpenBMC flash layout is used by Palmetto systems.

Add the unit name to the memory node to fix a warning with W=1.

Reviewed-by: C?dric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3:
 - Added memory node unit name
---
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index a8f0c046e83e..4379d09a261f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -12,7 +12,7 @@
 		bootargs = "console=ttyS4,115200 earlyprintk";
 	};
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x20000000>;
 	};
 
@@ -34,6 +34,7 @@
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
+#include "openbmc-flash-layout.dtsi"
 	};
 };
 
-- 
2.15.1
