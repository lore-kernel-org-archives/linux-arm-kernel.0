From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 11 May 2018 18:20:22 +0200
Subject: [PATCH 06/12] of: add a new flag for OF device nodes
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Message-ID: <20180511162028.20616-7-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This flag indicates that a device node has been populated early and
that it needs different handling when called from
of_platform_populate().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/of.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f952d9..49ba6427c6b2 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -143,6 +143,7 @@ extern raw_spinlock_t devtree_lock;
 #define OF_DETACHED	2 /* node has been detached from the device tree */
 #define OF_POPULATED	3 /* device already created for the node */
 #define OF_POPULATED_BUS	4 /* of_platform_populate recursed to children of this node */
+#define OF_POPULATED_EARLY	5 /* device is already allocated */
 
 #define OF_BAD_ADDR	((u64)-1)
 
-- 
2.17.0
