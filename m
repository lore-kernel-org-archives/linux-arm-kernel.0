From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Tue,  6 Dec 2016 16:03:47 +0000
Subject: [RFC PATCH v3 05/11] arm64: compat: Add time-related syscall numbers
In-Reply-To: <20161206160353.14581-1-kevin.brodsky@arm.com>
References: <20161206160353.14581-1-kevin.brodsky@arm.com>
Message-ID: <20161206160353.14581-6-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They will be used by the future compat vDSO.

The compat syscall numbers correspond to the arm syscall numbers, see
arch/arm/include/uapi/asm/unistd.h.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: Christopher Covington <cov@codeaurora.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/unistd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index e78ac26324bd..8d1c5f5e58f3 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -34,8 +34,10 @@
 #define __NR_compat_exit		1
 #define __NR_compat_read		3
 #define __NR_compat_write		4
+#define __NR_compat_gettimeofday	78
 #define __NR_compat_sigreturn		119
 #define __NR_compat_rt_sigreturn	173
+#define __NR_compat_clock_gettime	263
 
 /*
  * The following SVCs are ARM private.
-- 
2.10.2
