From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 11 Sep 2015 10:56:11 +0100
Subject: [PATCH 1/2] ARM: domains: thread_info.h no longer needs asm/domains.h
In-Reply-To: <20150911095438.GL21084@n2100.arm.linux.org.uk>
References: <20150911095438.GL21084@n2100.arm.linux.org.uk>
Message-ID: <E1ZaL3z-0003fm-IU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of 1eef5d2f1b46 ("ARM: domains: switch to keeping domain value in
register") we no longer need to include asm/domains.h into
asm/thread_info.h.  Remove it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/thread_info.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index d0a1119dcaf3..776757d1604a 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -25,7 +25,6 @@
 struct task_struct;
 
 #include <asm/types.h>
-#include <asm/domain.h>
 
 typedef unsigned long mm_segment_t;
 
-- 
2.1.0
