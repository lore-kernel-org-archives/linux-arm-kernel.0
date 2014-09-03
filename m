From: apinski@cavium.com (Andrew Pinski)
Date: Wed,  3 Sep 2014 14:19:14 -0700
Subject: [PATCH 20/24] ARM64:ILP32: The native siginfo is used instead of the
 compat siginfo
In-Reply-To: <1409779158-30963-1-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
Message-ID: <1409779158-30963-21-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set COMPAT_USE_NATIVE_SIGINFO to be true for non AARCH32 tasks.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/include/asm/compat.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 2f84d2c..87cb50d 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -211,6 +211,9 @@ typedef struct compat_siginfo {
 	} _sifields;
 } compat_siginfo_t;
 
+/* ILP32 uses the native siginfo and not the compat struct */
+#define COMPAT_USE_NATIVE_SIGINFO	(!is_a32_compat_task())
+
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
-- 
1.7.2.5
