From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu,  6 Sep 2012 15:12:13 +0300
Subject: [PATCH v3 06/14] dt: Add empty of_find_node_by_name() function
In-Reply-To: <1346933541-21547-1-git-send-email-peter.ujfalusi@ti.com>
References: <1346933541-21547-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1346933541-21547-7-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds an empty of_find_node_by_name() function for !CONFIG_OF
builds.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/of.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 1b11632..5c7a158 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -315,6 +315,12 @@ static inline const char* of_node_full_name(struct device_node *np)
 	return "<no-node>";
 }
 
+static inline struct device_node *of_find_node_by_name(struct device_node *from,
+	const char *name)
+{
+	return NULL;
+}
+
 static inline bool of_have_populated_dt(void)
 {
 	return false;
-- 
1.7.12
