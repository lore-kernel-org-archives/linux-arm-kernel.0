From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu,  8 Sep 2016 15:00:57 +0100
Subject: [RFC PATCH 2/8] arm64: compat: Add time-related syscall numbers
In-Reply-To: <20160908140103.7468-1-kevin.brodsky@arm.com>
References: <20160908140103.7468-1-kevin.brodsky@arm.com>
Message-ID: <20160908140103.7468-3-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They will be used by the future compat vDSO.

The compat syscall numbers correspond to the arm syscall numbers, see
arch/arm/include/uapi/asm/unistd.h.

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
2.9.3
