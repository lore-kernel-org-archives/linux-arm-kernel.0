From: finley.xiao@rock-chips.com (Finlye Xiao)
Date: Thu, 18 Aug 2016 16:52:19 +0800
Subject: [PATCH v2 2/4] of: introduce of_property_read_s32_index
In-Reply-To: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
References: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1471510341-63926-3-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

Introduce single indexed signed 32bit integer of_property_read method.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 include/linux/of.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 3d9ff8e..8ef775e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -929,6 +929,14 @@ static inline int of_property_read_s32(const struct device_node *np,
 	return of_property_read_u32(np, propname, (u32*) out_value);
 }
 
+static inline int of_property_read_s32_index(const struct device_node *np,
+					     const char *propname, u32 index,
+					     s32 *out_value)
+{
+	return of_property_read_u32_index(np, propname, index,
+		(u32 *)out_value);
+}
+
 #define of_for_each_phandle(it, err, np, ln, cn, cc)			\
 	for (of_phandle_iterator_init((it), (np), (ln), (cn), (cc)),	\
 	     err = of_phandle_iterator_next(it);			\
-- 
1.9.1
