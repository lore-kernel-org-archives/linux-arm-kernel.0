From: mark.brown314@gmail.com (Mark F. Brown)
Date: Thu, 26 Aug 2010 05:07:29 -0400
Subject: [PATCH 1/1] ARM: pxa168: fix corrected reset vector
In-Reply-To: <1282813649-8332-1-git-send-email-mark.brown314@gmail.com>
References: <1282813649-8332-1-git-send-email-mark.brown314@gmail.com>
Message-ID: <1282813649-8332-2-git-send-email-mark.brown314@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
---
 arch/arm/mach-mmp/include/mach/system.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/system.h b/arch/arm/mach-mmp/include/mach/system.h
index 4f5b0e0..926e9c0 100644
--- a/arch/arm/mach-mmp/include/mach/system.h
+++ b/arch/arm/mach-mmp/include/mach/system.h
@@ -16,6 +16,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	cpu_reset(0);
+	cpu_reset(0xffff0000);
 }
 #endif /* __ASM_MACH_SYSTEM_H */
-- 
1.7.0.4
