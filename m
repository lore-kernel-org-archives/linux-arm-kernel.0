From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 25 Oct 2011 14:01:26 +0200
Subject: [PATCH v3 1/3] dt: add empty of_machine_is_compatible
Message-ID: <1319544088-25946-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds an empty function for non-dt build, so that
drivers migrating to dt can save some '#ifdef CONFIG_OF'.

v3: New patch

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Patch 2 relies on this patch, but this patch would typically be merged via
Grant's OF/DT tree.

 include/linux/of.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 736b747..47303c7 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -302,6 +302,11 @@ static inline struct device_node *of_parse_phandle(struct device_node *np,
 	return NULL;
 }
 
+static inline int of_machine_is_compatible(const char *compat)
+{
+	return 0;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #endif /* CONFIG_OF */
 
-- 
1.7.4.1
