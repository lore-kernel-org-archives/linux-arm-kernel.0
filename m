From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu,  4 Sep 2014 17:03:37 +0100
Subject: [PATCH v1 3/6] arm64: Introduce dummy version of asm/fiq.h
In-Reply-To: <1409846620-14542-1-git-send-email-daniel.thompson@linaro.org>
References: <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
 <1409846620-14542-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1409846620-14542-4-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers that are shared between arm and arm64 and which employ
FIQ on arm cannot include asm/fiq.h without #ifdef'ing. This patch
introduces a dummy version of asm/fiq.h to arm64 to avoid this.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/fiq.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 arch/arm64/include/asm/fiq.h

diff --git a/arch/arm64/include/asm/fiq.h b/arch/arm64/include/asm/fiq.h
new file mode 100644
index 0000000..909ec54
--- /dev/null
+++ b/arch/arm64/include/asm/fiq.h
@@ -0,0 +1,18 @@
+/*
+ * arch/arm64/include/asm/fiq.h
+ *
+ * Placeholder to reduce #ifdef'ing in shared arm/arm64 drivers.
+ */
+
+#ifndef __ASM_FIQ_H
+#define __ASM_FIQ_H
+
+/*
+ * This placeholder allows code of the following form to be simplified:
+ *
+ * #ifdef CONFIG_FIQ
+ * #include <asm/fiq.h>
+ * #endif
+ */
+
+#endif
-- 
1.9.3
