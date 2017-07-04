From: johan@kernel.org (Johan Hovold)
Date: Tue,  4 Jul 2017 15:25:41 +0200
Subject: [PATCH 1/2] ARM: scu: add missing errno include
In-Reply-To: <20170704132542.27644-1-johan@kernel.org>
References: <20170704132542.27644-1-johan@kernel.org>
Message-ID: <20170704132542.27644-2-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing errno include to make the header self-contained and avoid
compilation breakage when compiling shared code without
CONFIG_HAVE_ARM_SCU.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/include/asm/smp_scu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index bfe163c40024..5983f6bc62d5 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -7,6 +7,7 @@
 
 #ifndef __ASSEMBLER__
 
+#include <linux/errno.h>
 #include <asm/cputype.h>
 
 static inline bool scu_a9_has_base(void)
-- 
2.13.2
