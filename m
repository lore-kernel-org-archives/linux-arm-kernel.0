From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  7 Nov 2014 16:25:26 +0000
Subject: [PATCH 01/11] of: Add empty of_get_next_parent stub
In-Reply-To: <1415377536-12841-1-git-send-email-mark.rutland@arm.com>
References: <1415377536-12841-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1415377536-12841-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no stub version of of_get_next_parent, so use in code compiled
without !CONFIG_OF will cause the kernel build to fail.

This patch adds a stub version of of_get_next_parent as is with other
!CONFIG_OF stub functions, so such code can compile without CONFIG_OF.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <rob.herring@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
---
 include/linux/of.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 6545e7a..2d4b7e0 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -392,6 +392,11 @@ static inline struct device_node *of_get_parent(const struct device_node *node)
 	return NULL;
 }
 
+static inline struct device_node *of_get_next_parent(struct device_node *node)
+{
+	return NULL;
+}
+
 static inline struct device_node *of_get_next_child(
 	const struct device_node *node, struct device_node *prev)
 {
-- 
1.9.1
