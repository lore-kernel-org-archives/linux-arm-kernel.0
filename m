From: apinski@cavium.com (Andrew Pinski)
Date: Sat, 24 May 2014 00:02:16 -0700
Subject: [PATCH 21/24] ARM64:ILP32: The native siginfo is used instead of the
 compat siginfo.
In-Reply-To: <1400914939-9708-1-git-send-email-apinski@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
Message-ID: <1400914939-9708-22-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set COMPAT_USE_NATIVE_SIGINFO to be true for non AARCH32 tasks.  The same reasoning why we check AARCH32 as we did for COMPAT_USE_64BIT_TIME_T.

Thanks,
Andrew Pinski

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/include/asm/compat.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index c77fc0f..aef8cd3 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -211,6 +211,9 @@ typedef struct compat_siginfo {
 	} _sifields;
 } compat_siginfo_t;
 
+/* ILP32 uses the native siginfo and not the compat struct */
+#define COMPAT_USE_NATIVE_SIGINFO	!is_a32_compat_task()
+
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
-- 
1.7.2.5
