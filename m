From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jul 2013 12:40:26 -0600
Subject: [PATCH V2 2/5] of: move documentation of of_parse_phandle_with_args
In-Reply-To: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
References: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1373913629-32179-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Commit bd69f73 "of: Create function for counting number of phandles in
a property" renamed of_parse_phandle_with_args(), and created a wrapper
function that implemented the original name. However, the documentation
of the original function was not moved, leaving it apparently documenting
the newly renamed function.

Move the documentation so that it is adjacent to the function it
documents.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/of/base.c | 64 +++++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5c54279..23e7073 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1104,38 +1104,6 @@ struct device_node *of_parse_phandle(const struct device_node *np,
 }
 EXPORT_SYMBOL(of_parse_phandle);
 
-/**
- * of_parse_phandle_with_args() - Find a node pointed by phandle in a list
- * @np:		pointer to a device tree node containing a list
- * @list_name:	property name that contains a list
- * @cells_name:	property name that specifies phandles' arguments count
- * @index:	index of a phandle to parse out
- * @out_args:	optional pointer to output arguments structure (will be filled)
- *
- * This function is useful to parse lists of phandles and their arguments.
- * Returns 0 on success and fills out_args, on error returns appropriate
- * errno value.
- *
- * Caller is responsible to call of_node_put() on the returned out_args->node
- * pointer.
- *
- * Example:
- *
- * phandle1: node1 {
- * 	#list-cells = <2>;
- * }
- *
- * phandle2: node2 {
- * 	#list-cells = <1>;
- * }
- *
- * node3 {
- * 	list = <&phandle1 1 2 &phandle2 3>;
- * }
- *
- * To get a device_node of the `node2' node you may call this:
- * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
- */
 static int __of_parse_phandle_with_args(const struct device_node *np,
 					const char *list_name,
 					const char *cells_name, int index,
@@ -1238,6 +1206,38 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 	return rc;
 }
 
+/**
+ * of_parse_phandle_with_args() - Find a node pointed by phandle in a list
+ * @np:		pointer to a device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cells_name:	property name that specifies phandles' arguments count
+ * @index:	index of a phandle to parse out
+ * @out_args:	optional pointer to output arguments structure (will be filled)
+ *
+ * This function is useful to parse lists of phandles and their arguments.
+ * Returns 0 on success and fills out_args, on error returns appropriate
+ * errno value.
+ *
+ * Caller is responsible to call of_node_put() on the returned out_args->node
+ * pointer.
+ *
+ * Example:
+ *
+ * phandle1: node1 {
+ * 	#list-cells = <2>;
+ * }
+ *
+ * phandle2: node2 {
+ * 	#list-cells = <1>;
+ * }
+ *
+ * node3 {
+ * 	list = <&phandle1 1 2 &phandle2 3>;
+ * }
+ *
+ * To get a device_node of the `node2' node you may call this:
+ * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
+ */
 int of_parse_phandle_with_args(const struct device_node *np, const char *list_name,
 				const char *cells_name, int index,
 				struct of_phandle_args *out_args)
-- 
1.8.1.5
