From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 30 Jun 2015 23:44:09 +0200
Subject: [RFC 1/3] of: make of_mutex public
In-Reply-To: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1435700651-3543-2-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

If we want to use OF_DYNAMIC features outside the of framework, we need
to access this lock. If OF maintainers don't like exporting, we can
maybe create accessor functions that we can use?

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/of/of_private.h | 1 -
 include/linux/of.h      | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 8e882e706cd8c6..f92ec41efb5dfd 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -31,7 +31,6 @@ struct alias_prop {
 	char stem[0];
 };
 
-extern struct mutex of_mutex;
 extern struct list_head aliases_lookup;
 extern struct kset *of_kset;
 
diff --git a/include/linux/of.h b/include/linux/of.h
index b871ff9d81d720..f0464efcbdc5aa 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -32,6 +32,8 @@
 typedef u32 phandle;
 typedef u32 ihandle;
 
+extern struct mutex of_mutex;
+
 struct property {
 	char	*name;
 	int	length;
-- 
2.1.4
