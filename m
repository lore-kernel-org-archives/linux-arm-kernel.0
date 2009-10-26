From: roel.kluin@gmail.com (Roel Kluin)
Date: Mon, 26 Oct 2009 22:33:04 +0100
Subject: [PATCH] icst307: Add missing increment
Message-ID: <4AE61590.2030603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this increment the loop can only break if it does in the
first iteration.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/arm/common/icst307.c b/arch/arm/common/icst307.c
index 6d094c1..b255fbf 100644
--- a/arch/arm/common/icst307.c
+++ b/arch/arm/common/icst307.c
@@ -55,7 +55,7 @@ icst307_khz_to_vco(const struct icst307_params *p, unsigned long freq)
 		 */
 		if (f > 6000 && f <= p->vco_max)
 			break;
-	} while (i < ARRAY_SIZE(idx2s));
+	} while (++i < ARRAY_SIZE(idx2s));
 
 	if (i >= ARRAY_SIZE(idx2s))
 		return vco;
@@ -117,7 +117,7 @@ icst307_ps_to_vco(const struct icst307_params *p, unsigned long period)
 		 */
 		if (f >= ps && f < 1000000000UL / 6000 + 1)
 			break;
-	} while (i < ARRAY_SIZE(idx2s));
+	} while (++i < ARRAY_SIZE(idx2s));
 
 	if (i >= ARRAY_SIZE(idx2s))
 		return vco;
