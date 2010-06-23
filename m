From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Jun 2010 19:52:17 +0800
Subject: [PATCH 5/6] [ARM] shmobile: change __io() definition to use
	__typesafe_io()
In-Reply-To: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
References: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1277293938-25804-6-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/mach-shmobile/include/mach/io.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/io.h b/arch/arm/mach-shmobile/include/mach/io.h
index 3e29649..19d5120 100644
--- a/arch/arm/mach-shmobile/include/mach/io.h
+++ b/arch/arm/mach-shmobile/include/mach/io.h
@@ -1,5 +1,5 @@
 #ifndef __ASM_MACH_IO_H
 #define __ASM_MACH_IO_H
 
-#define __io(a)			((void __iomem *)(a))
+#define __io(a)			__typesafe_io(a)
 #endif /* __ASM_MACH_IO_H */
-- 
1.7.1
