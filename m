From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 20:03:47 +0100
Subject: [PATCH 3/5] mvebu: fix missing include of common.h in cpu-reset.c
In-Reply-To: <1465326229-24787-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465326229-24787-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1465326229-24787-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu_cpu_reset_deassert() is missing the definition for
it, so include common.h where it is defined to fix the warning:

arch/arm/mach-mvebu/cpu-reset.c:25:5: warning: symbol 'mvebu_cpu_reset_deassert' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-mvebu/cpu-reset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mvebu/cpu-reset.c b/arch/arm/mach-mvebu/cpu-reset.c
index 4a2cadd..f33a31c 100644
--- a/arch/arm/mach-mvebu/cpu-reset.c
+++ b/arch/arm/mach-mvebu/cpu-reset.c
@@ -16,6 +16,8 @@
 #include <linux/io.h>
 #include <linux/resource.h>
 
+#include "common.h"
+
 static void __iomem *cpu_reset_base;
 static size_t cpu_reset_size;
 
-- 
2.8.1
