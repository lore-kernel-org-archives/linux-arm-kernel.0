From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Aug 2013 18:51:44 +0200
Subject: [PATCH 3/16] arch/arm/mach-ux500/cpu-db8500.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1376239917-15594-4-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
arity of the called function.

The semantic match that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,f;
@@

f(...,
- ARRAY_AND_SIZE(e)
+ e,ARRAY_SIZE(e)
  ,...)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not compiled.

 arch/arm/mach-ux500/cpu-db8500.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 12eee81..a73bb3d 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -157,7 +157,8 @@ static void __init db8500_add_gpios(struct device *parent)
 		.supports_sleepmode = true,
 	};
 
-	dbx500_add_gpios(parent, ARRAY_AND_SIZE(db8500_gpio_base),
+	dbx500_add_gpios(parent, db8500_gpio_base,
+			 ARRAY_SIZE(db8500_gpio_base),
 			 IRQ_DB8500_GPIO0, &pdata);
 	dbx500_add_pinctrl(parent, "pinctrl-db8500", U8500_PRCMU_BASE);
 }
