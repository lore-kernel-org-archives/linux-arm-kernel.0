From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Aug 2012 17:22:34 +0300
Subject: [PATCH v2 06/14] dt: Add empty of_find_node_by_name() function
In-Reply-To: <1344954162-7985-1-git-send-email-peter.ujfalusi@ti.com>
References: <1344954162-7985-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1344954162-7985-7-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds an empty of_find_node_by_name() function for !CONFIG_OF
builds.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/of.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 5919ee3..c90e59a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -308,6 +308,12 @@ static inline const char* of_node_full_name(struct device_node *np)
 	return "<no-node>";
 }
 
+static inline device_node *of_find_node_by_name(struct device_node *from,
+	const char *name)
+{
+	return NULL;
+}
+
 static inline bool of_have_populated_dt(void)
 {
 	return false;
-- 
1.7.8.6
