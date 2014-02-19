From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Wed, 19 Feb 2014 10:05:40 +0530
Subject: [PATCH v10 5/6] misc: debug: remove compilation warnings
In-Reply-To: <1392784541-18034-1-git-send-email-vijay.kilari@gmail.com>
References: <1392784541-18034-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1392784541-18034-6-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

typecast instruction_pointer macro to unsigned long to
resolve following compiler warnings like
warning: format '%lx' expects argument of type 'long unsigned int',
but argument 2 has type 'u64' [-Wformat]

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/ptrace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 0e7fa49..5233966 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -164,7 +164,7 @@ static inline int valid_user_regs(struct user_pt_regs *regs)
 	return 0;
 }
 
-#define instruction_pointer(regs)	(regs)->pc
+#define instruction_pointer(regs)	((unsigned long)(regs)->pc)
 
 #ifdef CONFIG_SMP
 extern unsigned long profile_pc(struct pt_regs *regs);
-- 
1.7.9.5
