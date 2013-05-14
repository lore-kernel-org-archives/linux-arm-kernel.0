From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 12:48:53 +0100
Subject: [PATCH 3/7] ARM: nommu: provide dummy cpu_switch_mm implementation
In-Reply-To: <1368532137-8871-1-git-send-email-jonathan.austin@arm.com>
References: <1368532137-8871-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368532137-8871-4-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

cpu_switch_mm is a logical nop on nommu systems, so define it as such
when !CONFIG_MMU.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/proc-fns.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index f3628fb..a6c99fe 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -137,6 +137,10 @@ extern void cpu_resume(void);
 	})
 #endif
 
+#else	/*!CONFIG_MMU */
+
+#define cpu_switch_mm(pgd,mm)	{ }
+
 #endif
 
 #endif /* __ASSEMBLY__ */
-- 
1.7.9.5
