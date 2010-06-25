From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 25 Jun 2010 15:44:29 +0800
Subject: [PATCH 2/4] [ARM] shmobile: change __io() definition to use
	__typesafe_io()
In-Reply-To: <1277451871-15319-1-git-send-email-eric.y.miao@gmail.com>
References: <1277451871-15319-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1277451871-15319-3-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Miao <eric.miao@canonical.com>

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/mach-shmobile/include/mach/io.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/io.h b/arch/arm/mach-shmobile/include/mach/io.h
index 7339fe4..df793df 100644
--- a/arch/arm/mach-shmobile/include/mach/io.h
+++ b/arch/arm/mach-shmobile/include/mach/io.h
@@ -3,7 +3,7 @@
 
 #define IO_SPACE_LIMIT		0xffffffff
 
-#define __io(a)			((void __iomem *)(a))
+#define __io(a)			__typesafe_io(a)
 #define __mem_pci(a)		(a)
 
 #endif /* __ASM_MACH_IO_H */
-- 
1.7.1
