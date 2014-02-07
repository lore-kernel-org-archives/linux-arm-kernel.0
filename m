From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri,  7 Feb 2014 19:10:01 +0900
Subject: [PATCH v4 1/3] arm64: Add regs_return_value() in syscall.h
In-Reply-To: <1391767803-5350-1-git-send-email-takahiro.akashi@linaro.org>
References: <1391410590-4884-1-git-send-email-takahiro.akashi@linaro.org>
 <1391767803-5350-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1391767803-5350-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This macro, regs_return_value, is used mainly for audit to record system
call's results, but may also be used in test_kprobes.c.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by Will Deacon <will.deacon@arm.com>
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
