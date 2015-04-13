From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 13 Apr 2015 21:44:31 +0200
Subject: [PATCH v4 21/24] arm64:ilp32: use the native siginfo instead of the
 compat siginfo
In-Reply-To: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
Message-ID: <3e04ba1c240f61575924763303612a3df9073052.1428953303.git.philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Set COMPAT_USE_NATIVE_SIGINFO to be true for non AARCH32 tasks.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 arch/arm64/include/asm/compat.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 4b717df..47f2b7a 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -217,6 +217,9 @@ typedef struct compat_siginfo {
 	} _sifields;
 } compat_siginfo_t;
 
+/* ILP32 uses the native siginfo and not the compat struct */
+#define COMPAT_USE_NATIVE_SIGINFO	!is_a32_compat_task()
+
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
-- 
1.9.1
