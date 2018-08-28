From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Aug 2018 20:52:03 -0500
Subject: [PATCH] ARM: shmobile: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Message-ID: <20180828015252.28511-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-renesas-soc at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index e348bcfe389d..9dd6cadcd900 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -189,7 +189,7 @@ static void __init add_special_pd(struct device_node *np, enum pd_types type)
 		return;
 	}
 
-	pr_debug("Special PM domain %s type %d for %pOF\n", pd->name, type, np);
+	pr_debug("Special PM domain %pOFn type %d for %pOF\n", pd, type, np);
 
 	special_pds[num_special_pds].pd = pd;
 	special_pds[num_special_pds].type = type;
-- 
2.17.1
