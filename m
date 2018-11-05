From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Nov 2018 13:06:42 +0000
Subject: [PATCH 03/10] arm64: add <asm/export.h>
In-Reply-To: <20181105130649.29429-1-mark.rutland@arm.com>
References: <20181105130649.29429-1-mark.rutland@arm.com>
Message-ID: <20181105130649.29429-4-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So that we can export symbols directly from assembly files, let's make
use of the generic <asm/export.h>. We have a few symbols that we'll want
to conditionally export for !KASAN kernel builds, so we add a helepr for
that.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/export.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 arch/arm64/include/asm/export.h

diff --git a/arch/arm64/include/asm/export.h b/arch/arm64/include/asm/export.h
new file mode 100644
index 000000000000..d7a82246816e
--- /dev/null
+++ b/arch/arm64/include/asm/export.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_EXPORT_H
+#define __ASM_EXPORT_H
+#include <asm-generic/export.h>
+
+#ifdef CONFIG_KASAN
+#define EXPORT_SYMBOL_NOKASAN(name)
+#else
+#define EXPORT_SYMBOL_NOKASAN(name)	EXPORT_SYMBOL(name)
+#endif
+
+#endif /* __ASM_EXPORT_H */
-- 
2.11.0
