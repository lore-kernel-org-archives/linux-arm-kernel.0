From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Jul 2017 16:43:30 -0500
Subject: [PATCH] soc/samsung: use kbasename instead of open coding
Message-ID: <20170718214339.7774-50-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to not store the full path of nodes in full_name, use
kbasename instead as it will work either with the full path or not.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
---
 drivers/soc/samsung/pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index c630eba32066..7c4fec1f93b5 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -147,7 +147,7 @@ static __init const char *exynos_get_domain_name(struct device_node *node)
 	const char *name;

 	if (of_property_read_string(node, "label", &name) < 0)
-		name = strrchr(node->full_name, '/') + 1;
+		name = kbasename(node->full_name);
 	return kstrdup_const(name, GFP_KERNEL);
 }

--
2.11.0
