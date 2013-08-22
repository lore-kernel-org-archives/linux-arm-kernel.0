From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 22 Aug 2013 22:57:30 -0000
Subject: [PATCH RFC v2 1/5] of: Add empty for_each_available_child_of_node()
 macro definition
In-Reply-To: <cover.1377202730.git.joshc@codeaurora.org>
References: <cover.1377202730.git.joshc@codeaurora.org>
Message-ID: <0fed3abba1286c59e51087efa02514d79e79ac14.1377202730.git.joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

Add this empty macro definition so users can be compiled without
excluding this macro call with preprocessor directives when CONFIG_OF
is disabled.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
This patch was first introduced in December @
http://thread.gmane.org/gmane.linux.drivers.devicetree/26315

 include/linux/of.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 1fd08ca..fefffb3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -369,6 +369,9 @@ static inline bool of_have_populated_dt(void)
 #define for_each_child_of_node(parent, child) \
 	while (0)
 
+#define for_each_available_child_of_node(parent, child) \
+	while (0)
+
 static inline struct device_node *of_get_child_by_name(
 					const struct device_node *node,
 					const char *name)
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
