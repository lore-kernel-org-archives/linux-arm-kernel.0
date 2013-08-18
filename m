From: msalter@redhat.com (Mark Salter)
Date: Sun, 18 Aug 2013 12:01:28 -0400
Subject: [PATCH] arm64: wire in generic parport.h
Message-ID: <1376841688.11104.8.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 port doesn't provide a parport.h which causes a build failure
with some configurations:

  drivers/parport/parport_pc.c:67:25: fatal error: asm/parport.h: No such file or directory
   #include <asm/parport.h>

This patch wires in the generic parport.h for arm64.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 79a642d..487b0a2 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -25,6 +25,7 @@ generic-y += local64.h
 generic-y += mman.h
 generic-y += msgbuf.h
 generic-y += mutex.h
+generic-y += parport.h                                                                                         
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += poll.h
-- 
1.8.1.4
