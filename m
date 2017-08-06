From: mikko.rapeli@iki.fi (Mikko Rapeli)
Date: Sun,  6 Aug 2017 18:44:05 +0200
Subject: [PATCH v06 14/36] arm uapi asm/signal.h: include <stddef.h> for
 size_t in userspace
In-Reply-To: <20170806164428.2273-1-mikko.rapeli@iki.fi>
References: <20170806164428.2273-1-mikko.rapeli@iki.fi>
Message-ID: <20170806164428.2273-15-mikko.rapeli@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> doubts that __kernel_size_t could be used here
so trying to fall back to gcc's <stddef.h>.

Fixes uapi header compilation error from userspace on ARCH=arm:

asm/signal.h:112:2: error: unknown type name ?size_t?
  size_t ss_size;

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/uapi/asm/signal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
index 33073bdcf091..63066f624c10 100644
--- a/arch/arm/include/uapi/asm/signal.h
+++ b/arch/arm/include/uapi/asm/signal.h
@@ -12,6 +12,8 @@ struct siginfo;
 #define NSIG		32
 typedef unsigned long sigset_t;
 
+#include <stddef.h>
+
 #endif /* __KERNEL__ */
 
 #define SIGHUP		 1
-- 
2.13.3
