From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 Feb 2016 11:15:05 +0900
Subject: [PATCH 3/9] ARM: uniphier: add missing of_node_put()
In-Reply-To: <1455588911-9827-1-git-send-email-yamada.masahiro@socionext.com>
References: <1455588911-9827-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1455588911-9827-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node pointer is allocated by of_find_compatible_node() in this
function.  It should be put before exitting this function.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
index b53a8d9..fad568d 100644
--- a/arch/arm/mach-uniphier/platsmp.c
+++ b/arch/arm/mach-uniphier/platsmp.c
@@ -100,6 +100,7 @@ static int __init uniphier_smp_prepare_trampoline(unsigned int max_cpus)
 
 	np = of_find_compatible_node(NULL, NULL, "socionext,uniphier-smpctrl");
 	ret = of_address_to_resource(np, 0, &res);
+	of_node_put(np);
 	if (ret) {
 		pr_err("failed to get resource of uniphier-smpctrl\n");
 		return ret;
-- 
1.9.1
