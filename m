From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 10 Oct 2011 21:49:35 +0530
Subject: [PATCH v2 2/5] dt: add empty dt helpers for non-dt build
In-Reply-To: <1318263578-7407-1-git-send-email-rnayak@ti.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
Message-ID: <1318263578-7407-3-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add empty of_device_is_compatible(), of_find_property()
and of_parse_phandle() for non-dt builds to work.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 include/linux/of.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 9180dc5..47ce461 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -263,6 +263,25 @@ static inline const void *of_get_property(const struct device_node *node,
 	return NULL;
 }
 
+static inline int of_device_is_compatible(const struct device_node *device,
+				   const char *name)
+{
+	return 0;
+}
+
+static inline struct property *of_find_property(const struct device_node *np,
+					 const char *name,
+					 int *lenp)
+{
+	return NULL;
+}
+
+static inline struct device_node *of_parse_phandle(struct device_node *np,
+					    const char *phandle_name,
+					    int index)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF */
 
 static inline int of_property_read_u32(const struct device_node *np,
-- 
1.7.1
