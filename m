From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 13 Mar 2014 10:49:23 -0700
Subject: [PATCH] arm64: Add ARCH_HAS_SG_CHAIN
Message-ID: <1394732963-12174-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's useful to be able to chain scatterlists together for very large
scatter allocations. Define ARCH_HAS_SG_CHAIN to let this happen.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/include/asm/scatterlist.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 arch/arm64/include/asm/scatterlist.h

diff --git a/arch/arm64/include/asm/scatterlist.h b/arch/arm64/include/asm/scatterlist.h
new file mode 100644
index 0000000..7b2602a
--- /dev/null
+++ b/arch/arm64/include/asm/scatterlist.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ASM_SCATTERLIST_H
+#define __ASM_SCATTERLIST_H
+
+#include <asm-generic/scatterlist.h>
+
+#define ARCH_HAS_SG_CHAIN
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
