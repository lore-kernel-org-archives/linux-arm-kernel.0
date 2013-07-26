From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 26 Jul 2013 10:18:04 -0300
Subject: [PATCH v9 27/30] ARM: kirkwood: Introduce MBUS_ID
In-Reply-To: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1374844687-19981-28-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This macro is used to define window's target ID and attribute cells
for the MBus ranges entries.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/kirkwood.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 83d53b3..5003c83 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -1,5 +1,7 @@
 /include/ "skeleton.dtsi"
 
+#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
+
 / {
 	compatible = "marvell,kirkwood";
 	interrupt-parent = <&intc>;
-- 
1.8.1.5
