From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 16 Jul 2018 16:41:46 +0200
Subject: [PATCH v3 03/23] thermal: armada: remove misleading comments
In-Reply-To: <20180716144206.30985-1-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
Message-ID: <20180716144206.30985-4-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On older versions of this thermal IP, TSEN referred as the internal
sensor in the thermal IP while EXT_TSEN referred as sensors outside of
this IP, ie in the CPUs most of the time. The bit names in the
specifications do not follow this rule anymore, so remove these comments
that are misleading.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 6fdb90b3c001..18155e43e67f 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -51,12 +51,10 @@
 #define CONTROL0_TSEN_TC_TRIM_MASK	0x7
 #define CONTROL0_TSEN_TC_TRIM_VAL	0x3
 
-/* TSEN refers to the temperature sensors within the AP */
 #define CONTROL0_TSEN_START		BIT(0)
 #define CONTROL0_TSEN_RESET		BIT(1)
 #define CONTROL0_TSEN_ENABLE		BIT(2)
 
-/* EXT_TSEN refers to the external temperature sensors, out of the AP */
 #define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
 #define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)
 
-- 
2.14.1
