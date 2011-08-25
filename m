From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 25 Aug 2011 17:43:37 -0600
Subject: [PATCH v3 06/13] dt: add empty for_each_child_of_node,
	of_find_property
In-Reply-To: <1314315824-9687-1-git-send-email-swarren@nvidia.com>
References: <1314315824-9687-1-git-send-email-swarren@nvidia.com>
Message-ID: <1314315824-9687-7-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds a couple empty functions for non-dt build, so that
drivers migrating to dt can save some '#ifdef CONFIG_OF'.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/linux/of.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 9180dc5..1fc5875 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -242,6 +242,16 @@ static inline bool of_have_populated_dt(void)
 	return false;
 }
 
+#define for_each_child_of_node(parent, child) \
+	while (0)
+
+static inline struct property *of_find_property(const struct device_node *np,
+						const char *name,
+						int *lenp)
+{
+	return NULL;
+}
+
 static inline int of_property_read_u32_array(const struct device_node *np,
 					     const char *propname,
 					     u32 *out_values, size_t sz)
-- 
1.7.0.4
