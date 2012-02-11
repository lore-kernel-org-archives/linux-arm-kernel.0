From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 11 Feb 2012 09:14:26 -0800
Subject: [PATCH 2/8] dt: add empty of_find_compatible_node function
In-Reply-To: <1328980472-11923-1-git-send-email-shawn.guo@linaro.org>
References: <1328980472-11923-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1328980472-11923-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add empty of_find_compatible_node function for !CONFIG_OF build.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 include/linux/of.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index a75a831..92cf6ad 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -281,6 +281,14 @@ static inline struct property *of_find_property(const struct device_node *np,
 	return NULL;
 }
 
+static inline struct device_node *of_find_compatible_node(
+						struct device_node *from,
+						const char *type,
+						const char *compat)
+{
+	return NULL;
+}
+
 static inline int of_property_read_u32_array(const struct device_node *np,
 					     const char *propname,
 					     u32 *out_values, size_t sz)
-- 
1.7.5.4
