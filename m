From: trong@android.com (Tri Vo)
Date: Wed, 19 Sep 2018 12:27:50 -0700
Subject: [RFC] arm64: lse: remove -fcall-used-x0 flag
Message-ID: <20180919192750.200491-1-trong@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

x0 is not callee-saved in the PCS. So there is no need to specify
-fcall-used-x0.

Clang doesn't currently support -fcall-used flags. This patch will help
building the kernel with clang.

Signed-off-by: Tri Vo <trong@android.com>
---
 arch/arm64/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index c86b7909ef31..2f7c60c8e588 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -11,7 +11,7 @@ lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
 # when supported by the CPU. Result and argument registers are handled
 # correctly, based on the function prototype.
 lib-$(CONFIG_ARM64_LSE_ATOMICS) += atomic_ll_sc.o
-CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
+CFLAGS_atomic_ll_sc.o	:= -ffixed-x1 -ffixed-x2        		\
 		   -ffixed-x3 -ffixed-x4 -ffixed-x5 -ffixed-x6		\
 		   -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9		\
 		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
--
2.19.0.397.gdd90340f6a-goog
