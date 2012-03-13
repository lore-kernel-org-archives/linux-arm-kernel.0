From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 13 Mar 2012 18:48:23 +0100
Subject: [PATCH v4] of: introduce helper to manage boolean
Message-ID: <1331660903-10193-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_property_read_bool

Search for a property in a device node.
Returns true if the property exist false otherwise.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
v4:

	send the right version

	include Grant comment

	Grant can I get the go please?

Best Regards,
J.
 include/linux/of.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index a75a831..a992cdf 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -342,6 +342,22 @@ static inline int of_machine_is_compatible(const char *compat)
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
 
+/**
+ * of_property_read_bool - Findfrom a property
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ *
+ * Search for a property in a device node.
+ * Returns true if the property exist false otherwise.
+ */
+static inline bool of_property_read_bool(const struct device_node *np,
+					 const char *propname)
+{
+	struct property *prop = of_find_property(np, propname, NULL);
+
+	return prop ? true : false;
+}
+
 static inline int of_property_read_u32(const struct device_node *np,
 				       const char *propname,
 				       u32 *out_value)
-- 
1.7.7
