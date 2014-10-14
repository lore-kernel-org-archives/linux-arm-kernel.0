From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 14 Oct 2014 14:20:44 +0200
Subject: [PATCH 6/8] power: apm_power: Use power_supply_*() API for accessing
 function attrs
In-Reply-To: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
References: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1413289246-31650-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace direct calls to power supply function attributes with wrappers.
Wrappers provide safe access access in case of unregistering the power
supply (.e.g by removing the driver). Replace:
 - get_property -> power_supply_get_property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/apm_power.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/apm_power.c b/drivers/power/apm_power.c
index 39763015b360..2206f9ff6488 100644
--- a/drivers/power/apm_power.c
+++ b/drivers/power/apm_power.c
@@ -15,10 +15,10 @@
 #include <linux/apm-emulation.h>
 
 
-#define PSY_PROP(psy, prop, val) (psy->get_property(psy, \
+#define PSY_PROP(psy, prop, val) (power_supply_get_property(psy, \
 			 POWER_SUPPLY_PROP_##prop, val))
 
-#define _MPSY_PROP(prop, val) (main_battery->get_property(main_battery, \
+#define _MPSY_PROP(prop, val) (power_supply_get_property(main_battery, \
 							 prop, val))
 
 #define MPSY_PROP(prop, val) _MPSY_PROP(POWER_SUPPLY_PROP_##prop, val)
-- 
1.9.1
