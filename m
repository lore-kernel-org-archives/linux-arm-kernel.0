From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 27 Oct 2011 11:07:28 +0200
Subject: [PATCH] dt: add empty of_alias_get_id() for non-dt builds
Message-ID: <1319706448-1664-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add function of_alias_get_id() reporting -ENOSYS
for non-dt builds, so that drivers migrating to dt
can save some '#ifdef CONFIG_OF'.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi Grant,

Another empty function for non-dt builds. Can we consider
queuing it for 3.1?

Best regards,

 include/linux/of.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 92c40a1..34d8338 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -302,6 +302,11 @@ static inline struct device_node *of_parse_phandle(struct device_node *np,
 	return NULL;
 }
 
+static inline int of_alias_get_id(struct device_node *np, const char *stem)
+{
+	return -ENOSYS;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
-- 
1.7.5.4
