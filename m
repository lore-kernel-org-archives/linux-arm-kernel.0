From: joshc@codeaurora.org (Josh Cartwright)
Date: Mon, 28 Oct 2013 13:12:35 -0500
Subject: [PATCH v3 01/10] of: Add empty for_each_available_child_of_node()
 macro definition
In-Reply-To: <cover.1382985169.git.joshc@codeaurora.org>
References: <cover.1382985169.git.joshc@codeaurora.org>
Message-ID: <3518ab21e436f5c1a7bdd900a796bb05f9162bbf.1382985169.git.joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

Add this empty macro definition so users can be compiled without
excluding this macro call with preprocessor directives when CONFIG_OF
is disabled.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/of.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index f95aee3..908584e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -364,6 +364,9 @@ static inline bool of_have_populated_dt(void)
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
