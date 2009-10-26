From: roel.kluin@gmail.com (Roel Kluin)
Date: Mon, 26 Oct 2009 22:46:35 +0100
Subject: [PATCH] icst525: Add missing increment
In-Reply-To: <4AE61590.2030603@gmail.com>
References: <4AE61590.2030603@gmail.com>
Message-ID: <4AE618BB.4060601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this increment the loop can only break if it does in the
first iteration.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/arm/common/icst525.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Same issue, different file.

diff --git a/arch/arm/common/icst525.c b/arch/arm/common/icst525.c
index 3d377c5..0aef96a 100644
--- a/arch/arm/common/icst525.c
+++ b/arch/arm/common/icst525.c
@@ -53,7 +53,7 @@ icst525_khz_to_vco(const struct icst525_params *p, unsigned long freq)
 		 */
 		if (f > 10000 && f <= p->vco_max)
 			break;
-	} while (i < ARRAY_SIZE(idx2s));
+	} while (++i < ARRAY_SIZE(idx2s));
 
 	if (i >= ARRAY_SIZE(idx2s))
 		return vco;
@@ -116,7 +116,7 @@ icst525_ps_to_vco(const struct icst525_params *p, unsigned long period)
 		 */
 		if (f >= ps && f < 100000)
 			break;
-	} while (i < ARRAY_SIZE(idx2s));
+	} while (++i < ARRAY_SIZE(idx2s));
 
 	if (i >= ARRAY_SIZE(idx2s))
 		return vco;
