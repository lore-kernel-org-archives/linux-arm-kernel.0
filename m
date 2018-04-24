From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 24 Apr 2018 19:30:46 +0200
Subject: [PATCH 06/11] of: provide for_each_compatible_child_node()
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
Message-ID: <20180424173051.15099-7-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a variant of for_each_compatible_node() allowing to only iterate
over all compatible nodes that are children of the specified root node.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/of.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f952d9..15e0dbf7a602 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1170,6 +1170,9 @@ static inline int of_property_read_s32(const struct device_node *np,
 #define for_each_compatible_node(dn, type, compatible) \
 	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
 	     dn = of_find_compatible_node(dn, type, compatible))
+#define for_each_compatible_child_node(dn, type, compatible, root) \
+	for (dn = of_find_compatible_node(root, type, compatible); dn; \
+	     dn = of_find_compatible_node(dn, type, compatible))
 #define for_each_matching_node(dn, matches) \
 	for (dn = of_find_matching_node(NULL, matches); dn; \
 	     dn = of_find_matching_node(dn, matches))
-- 
2.17.0
