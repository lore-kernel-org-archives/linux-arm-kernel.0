From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:02 +0100
Subject: [PATCH 01/18] arm64: cpufeature.h: add missing #include of kernel.h
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpufeature.h makes use of DECLARE_BITMAP, which in turn relies on the
BITS_TO_LONGS and DIV_ROUND_UP macros.

This patch includes kernel.h in cpufeature.h to prevent all users having
to do the same thing.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c1044218a63a..eb09f1ee8036 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -30,6 +30,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/kernel.h>
+
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
-- 
2.1.4
