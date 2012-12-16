From: olof@lixom.net (Olof Johansson)
Date: Sat, 15 Dec 2012 23:25:14 -0800
Subject: [PATCH] ARM: davinci: fix build break due to missing include
Message-ID: <1355642714-26879-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-davinci/board-da850-evm.c: In function 'da850_evm_init':
arch/arm/mach-davinci/board-da850-evm.c:1516:2: error: implicit declaration of function 'sram_get_gen_pool' [-Werror=implicit-function-declaration]
arch/arm/mach-davinci/board-da850-evm.c:1516:31: warning: assignment makes pointer from integer without a cast [enabled by default]

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---

I've added this to the 'fixes' branch on arm-soc.

 arch/arm/mach-davinci/board-da850-evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 7211772..0299915 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -41,6 +41,7 @@
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
 #include <mach/mux.h>
+#include <mach/sram.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-- 
1.7.10.1.488.g05fbf7a
