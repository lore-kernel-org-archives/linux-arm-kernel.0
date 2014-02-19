From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 19 Feb 2014 17:58:43 +0100
Subject: [PATCH RFC v1 2/3] of: Add definition of maximum length of a property
 name
In-Reply-To: <1392829124-25705-1-git-send-email-s.nawrocki@samsung.com>
References: <1392829124-25705-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1392829124-25705-3-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maximum length of a property name is defined by ePAPR (2.2.4.1) as
31 characters. Add a corresponding definition, including the trailing
null space.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/of.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 70c64ba..7f71221 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -30,6 +30,9 @@
 typedef u32 phandle;
 typedef u32 ihandle;
 
+/* Maximum length of name of a property, including terminating null */
+#define OF_PROP_NAME_MAXLEN	32
+
 struct property {
 	char	*name;
 	int	length;
-- 
1.7.9.5
