From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Nov 2013 23:05:29 -0800
Subject: [PATCH] ARM: nommu: add missing include of asm/procinfo.h
Message-ID: <1384326329-8281-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building for nommu, the following warning results:

arch/arm/mm/nommu.c:303:17: warning: 'struct proc_info_list' declared
    inside parameter list

Add the missing include of asm/procinfo.h.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mm/nommu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 5c668b7..55764a7 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -18,6 +18,7 @@
 #include <asm/mach/arch.h>
 #include <asm/cputype.h>
 #include <asm/mpu.h>
+#include <asm/procinfo.h>
 
 #include "mm.h"
 
-- 
1.7.10.4
