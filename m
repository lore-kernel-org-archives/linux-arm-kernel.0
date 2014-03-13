From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 13 Mar 2014 19:11:31 +0900
Subject: [PATCH v4 3/3] arm64: Add regs_return_value() in syscall.h
In-Reply-To: <1394705491-12343-1-git-send-email-takahiro.akashi@linaro.org>
References: <1393564465-3862-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705491-12343-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1394705491-12343-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This macro, regs_return_value, is used mainly for audit to record system
call's results, but may also be used in test_kprobes.c.

Acked-by Will Deacon <will.deacon@arm.com>
Acked-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/ptrace.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 0e7fa49..5800ec1 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -134,6 +134,11 @@ struct pt_regs {
 #define user_stack_pointer(regs) \
 	((regs)->sp)
 
+static inline unsigned long regs_return_value(struct pt_regs *regs)
+{
+	return regs->regs[0];
+}
+
 /*
  * Are the current registers suitable for user mode? (used to maintain
  * security in signal handlers)
-- 
1.7.9.5
