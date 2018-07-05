From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  5 Jul 2018 18:04:36 +0200
Subject: [PATCH v3 22/23] arm64: dts: marvell: add macro to make distinction
 between node names
In-Reply-To: <20180705160437.12325-1-miquel.raynal@bootlin.com>
References: <20180705160437.12325-1-miquel.raynal@bootlin.com>
Message-ID: <20180705160437.12325-23-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the label is different between CPs, the full path of a node is
unique. However, when referring to the end of the path only (the node
name), this name is not unique anymore.

The *thermal_zone_of_sensor_register() functions of the thermal core
present this limitation and prevent having a thermal-zone per CP.

Add a macro to make the distinction between node names to solve this
situation.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-common.dtsi b/arch/arm64/boot/dts/marvell/armada-common.dtsi
index d5e8aedec188..b29c6405d214 100644
--- a/arch/arm64/boot/dts/marvell/armada-common.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-common.dtsi
@@ -7,4 +7,5 @@
 #define PASTER(x, y) x ## y
 #define EVALUATOR(x, y) PASTER(x, y)
 #define CP110_LABEL(name) EVALUATOR(CP110_NAME, EVALUATOR(_, name))
+#define CP110_NODE_NAME(name) EVALUATOR(CP110_NAME, EVALUATOR(-, name))
 #define ADDRESSIFY(addr) EVALUATOR(0x, addr)
-- 
2.14.1
