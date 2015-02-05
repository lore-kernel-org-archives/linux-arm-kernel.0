From: balbi@ti.com (Felipe Balbi)
Date: Thu, 5 Feb 2015 12:01:05 -0600
Subject: [RFC/PATCH 1/2] of: move of_property_read_bool further down
Message-ID: <1423159266-25561-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A follow-up patch will make use of of_property_read_u32()
to allow for boolean properties to have a value, this
is just in preparation for that patch in order to make
review easier.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 include/linux/of.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index dfde07e77a63..76c055b20fef 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -765,22 +765,6 @@ static inline int of_property_read_string_index(struct device_node *np,
 	return rc < 0 ? rc : 0;
 }
 
-/**
- * of_property_read_bool - Findfrom a property
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- *
- * Search for a property in a device node.
- * Returns true if the property exist false otherwise.
- */
-static inline bool of_property_read_bool(const struct device_node *np,
-					 const char *propname)
-{
-	struct property *prop = of_find_property(np, propname, NULL);
-
-	return prop ? true : false;
-}
-
 static inline int of_property_read_u8(const struct device_node *np,
 				       const char *propname,
 				       u8 *out_value)
@@ -802,6 +786,22 @@ static inline int of_property_read_u32(const struct device_node *np,
 	return of_property_read_u32_array(np, propname, out_value, 1);
 }
 
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
 static inline int of_property_read_s32(const struct device_node *np,
 				       const char *propname,
 				       s32 *out_value)
-- 
2.3.0-rc1
