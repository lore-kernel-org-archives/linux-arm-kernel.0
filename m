From: panand@redhat.com (Pratyush Anand)
Date: Thu, 18 Jun 2015 09:28:51 +0530
Subject: [RFC PATCH V2 04/10] arm64: Add helper for link pointer
In-Reply-To: <cover.1434598237.git.panand@redhat.com>
References: <cover.1434598237.git.panand@redhat.com>
Message-ID: <9b12762abf045a08c930f71537edf1affcca0c5c.1434598237.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At many a place we program procedure link pointer ie regs[30]. So adding
helper to do that.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/include/asm/ptrace.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 3ea7f5a04bfc..fa2c122e5bd6 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -227,6 +227,13 @@ static inline int valid_user_regs(struct user_pt_regs *regs)
 #include <asm-generic/ptrace.h>
 
 #define stack_pointer(regs)		((regs)->sp)
+#define procedure_link_pointer(regs)	((regs)->regs[30])
+
+static inline void procedure_link_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	procedure_link_pointer(regs) = val;
+}
 
 #ifdef CONFIG_SMP
 #undef profile_pc
-- 
2.1.0
