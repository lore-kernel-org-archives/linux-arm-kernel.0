From: mikko.rapeli@iki.fi (Mikko Rapeli)
Date: Thu, 15 Oct 2015 07:56:57 +0200
Subject: [PATCH v4 79/79] arch/arm/include/uapi/asm/signal.h: use
 __kernel_size_t instead of size_t
In-Reply-To: <1444888618-4506-1-git-send-email-mikko.rapeli@iki.fi>
References: <1444888618-4506-1-git-send-email-mikko.rapeli@iki.fi>
Message-ID: <1444888618-4506-80-git-send-email-mikko.rapeli@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes uapi header compilation error from userspace on ARCH=arm:

asm/signal.h:112:2: error: unknown type name ?size_t?
  size_t ss_size;

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 arch/arm/include/uapi/asm/signal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
index 33073bd..859f2de 100644
--- a/arch/arm/include/uapi/asm/signal.h
+++ b/arch/arm/include/uapi/asm/signal.h
@@ -113,7 +113,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 
-- 
2.5.0
