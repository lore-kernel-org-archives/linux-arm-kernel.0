From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 22 Dec 2011 20:19:24 +0800
Subject: [PATCH v2 1/1] dt: reform for_each_property to
 for_each_property_of_node
Message-ID: <1324556364-26188-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Make this macro easier to use(do not need to pass properties, a node is
enough), also change to a more sensible name as for_each_child_of_node.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
Changes v1->v2:
- Fix a typo error (micro->macro)

---
 drivers/of/base.c  |    2 +-
 include/linux/of.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9b6588e..f6f6fe8 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1159,7 +1159,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 	if (!of_aliases)
 		return;
 
-	for_each_property(pp, of_aliases->properties) {
+	for_each_property_of_node(of_aliases, pp) {
 		const char *start = pp->name;
 		const char *end = start + strlen(start);
 		struct device_node *np;
diff --git a/include/linux/of.h b/include/linux/of.h
index 4948552..f1a490c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -219,8 +219,8 @@ extern int of_device_is_available(const struct device_node *device);
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
-#define for_each_property(pp, properties) \
-	for (pp = properties; pp != NULL; pp = pp->next)
+#define for_each_property_of_node(dn, pp) \
+	for (pp = dn->properties; pp != NULL; pp = pp->next)
 
 extern int of_n_addr_cells(struct device_node *np);
 extern int of_n_size_cells(struct device_node *np);
-- 
1.7.0.4
