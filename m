From: himangi774@gmail.com (Himangi Saraogi)
Date: Wed, 13 Aug 2014 14:48:04 +0530
Subject: [PATCH] ARM: integrator: Drop unnecessary continue
Message-ID: <20140813091804.GA3043@himangi-Dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Continue is not needed at the bottom of a loop.

The Coccinelle semantic patch implementing this change is:

@@
@@

for (...;...;...) {
  ...
  if (...) {
    ...
-   continue;
  }
}

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 arch/arm/mach-integrator/impd1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 3ce8807..c4eb8c9 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -376,10 +376,8 @@ static int __init_refok impd1_probe(struct lm_device *dev)
 					    irq1, irq2,
 					    idev->platform_data, idev->id,
 					    &dev->resource);
-		if (IS_ERR(d)) {
+		if (IS_ERR(d))
 			dev_err(&dev->dev, "unable to register device: %ld\n", PTR_ERR(d));
-			continue;
-		}
 	}
 
 	return 0;
-- 
1.9.1
