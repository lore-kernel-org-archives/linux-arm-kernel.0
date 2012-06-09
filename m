From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Sat,  9 Jun 2012 05:13:27 -0300
Subject: =?UTF-8?q?=5BPATCH=202/6=5D=20arm=3A=20fix=20compiler=20warning=20by=20properly=20inlining=20flat=5Fset=5Fpersistent=28=29?=
In-Reply-To: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
References: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
Message-ID: <1339229611-2326-2-git-send-email-elezegarcia@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the following warning:
fs/binfmt_flat.c:752: warning: unused variable ?persistent?
There is neither change in functionality, nor extra code generated.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
---
 arch/arm/include/asm/flat.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/flat.h b/arch/arm/include/asm/flat.h
index 59426a4..6ef6cc5 100644
--- a/arch/arm/include/asm/flat.h
+++ b/arch/arm/include/asm/flat.h
@@ -11,6 +11,11 @@
 #define	flat_get_addr_from_rp(rp, relval, flags, persistent) get_unaligned(rp)
 #define	flat_put_addr_at_rp(rp, val, relval)	put_unaligned(val,rp)
 #define	flat_get_relocate_addr(rel)		(rel)
-#define	flat_set_persistent(relval, p)		0
+
+static inline int flat_set_persistent(unsigned long relval,
+				      unsigned long *persistent)
+{
+	return 0;
+}
 
 #endif /* __ARM_FLAT_H__ */
-- 
1.7.3.4
