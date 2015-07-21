From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:43 +0200
Subject: [RFC PATCH 01/16] typecheck_member and offsetof_t
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 include/linux/stddef.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 9c61c7cda936..e60bd164c03a 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -27,4 +27,11 @@ enum {
 #define offsetofend(TYPE, MEMBER) \
 	(offsetof(TYPE, MEMBER)	+ sizeof(((TYPE *)0)->MEMBER))
 
+#define typecheck_member(TYPE, MEMBER, MEMBERTYPE) \
+	((size_t)(&((TYPE *)0)->MEMBER - (MEMBERTYPE*)0) ? 0 : 0)
+
+/* like offsetof(), but ensures that MEMBER is of type MEMBERTYPE */
+#define offsetof_t(TYPE, MEMBER, MEMBERTYPE) \
+	(typecheck_member(TYPE, MEMBER, MEMBERTYPE) + offsetof(TYPE, MEMBER))
+
 #endif
-- 
2.4.3
