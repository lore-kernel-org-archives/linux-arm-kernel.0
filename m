From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 20 May 2013 16:16:34 +0800
Subject: [PATCH] include/linux/posix_acl.h: need 'return NULL' when BUG(),
 if neither CONFIG_BUG nor HAVE_ARCH_BUG is defined.
Message-ID: <5199DBE2.5080707@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


If neither CONFIG_BUG nor HAVE_ARCH_BUG is defined, the BUG() will
defined as empty (e.g. randconfig with MMU for arm s5pv210)

In this case, need 'return NULL' to let upper caller knows the failure.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 include/linux/posix_acl.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 7931efe..2c48d06 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -104,6 +104,7 @@ static inline struct posix_acl **acl_by_type(struct inode *inode, int type)
 		return &inode->i_default_acl;
 	default:
 		BUG();
+		return NULL;
 	}
 }
 
-- 
1.7.7.6
