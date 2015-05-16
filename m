From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Sat, 16 May 2015 15:58:23 +0800
Subject: [PATCH v2 2/9] ARM: add secondary_startup_arm prototype in header file
In-Reply-To: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1431763110-443-3-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Put secondary_startup_arm() prototype in arch/arm/include/asm/smp.h
so users doesn't have to add extern prototype in their code.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 arch/arm/include/asm/smp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 18f5a55..f5cffb7 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -69,6 +69,7 @@ struct secondary_data {
 extern struct secondary_data secondary_data;
 extern volatile int pen_release;
 extern void secondary_startup(void);
+extern void secondary_startup_arm(void);
 
 extern int __cpu_disable(void);
 
-- 
1.8.1.1.dirty
