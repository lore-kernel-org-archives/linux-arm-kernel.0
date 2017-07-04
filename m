From: johan@kernel.org (Johan Hovold)
Date: Tue,  4 Jul 2017 15:25:42 +0200
Subject: [PATCH 2/2] ARM: pm: add missing types include
In-Reply-To: <20170704132542.27644-1-johan@kernel.org>
References: <20170704132542.27644-1-johan@kernel.org>
Message-ID: <20170704132542.27644-3-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing types.h include to make the suspend header self-contained
and avoid compilation breakage due to include-directive ordering.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/include/asm/suspend.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
index 6c7182f32cef..a61905c86732 100644
--- a/arch/arm/include/asm/suspend.h
+++ b/arch/arm/include/asm/suspend.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_ARM_SUSPEND_H
 #define __ASM_ARM_SUSPEND_H
 
+#include <linux/types.h>
+
 struct sleep_save_sp {
 	u32 *save_ptr_stash;
 	u32 save_ptr_stash_phys;
-- 
2.13.2
