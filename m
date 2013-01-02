From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:54 -0800
Subject: [PATCH 17/26] ARM: S3C2416: remove regs-s3c2416-mem.h and
 regs-s3c2416.h
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-18-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The headers no longer used anywhere now.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 .../mach-s3c24xx/include/mach/regs-s3c2416-mem.h   |   30 --------------------
 arch/arm/mach-s3c24xx/include/mach/regs-s3c2416.h  |   24 ----------------
 2 files changed, 54 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-s3c2416-mem.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-s3c2416.h

diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2416-mem.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2416-mem.h
deleted file mode 100644
index 2f31b74..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2416-mem.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h
- *
- * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
- *	as part of OpenInkpot project
- * Copyright (c) 2009 Promwad Innovation Company
- *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2416 memory register definitions
-*/
-
-#ifndef __ASM_ARM_REGS_S3C2416_MEM
-#define __ASM_ARM_REGS_S3C2416_MEM
-
-#ifndef S3C2416_MEMREG
-#define S3C2416_MEMREG(x) (S3C24XX_VA_MEMCTRL + (x))
-#endif
-
-#define S3C2416_BANKCFG			S3C2416_MEMREG(0x00)
-#define S3C2416_BANKCON1		S3C2416_MEMREG(0x04)
-#define S3C2416_BANKCON2		S3C2416_MEMREG(0x08)
-#define S3C2416_BANKCON3		S3C2416_MEMREG(0x0C)
-
-#define S3C2416_REFRESH			S3C2416_MEMREG(0x10)
-#define S3C2416_TIMEOUT			S3C2416_MEMREG(0x14)
-
-#endif /*  __ASM_ARM_REGS_S3C2416_MEM */
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2416.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2416.h
deleted file mode 100644
index e443167..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2416.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h
- *
- * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
- *	as part of OpenInkpot project
- * Copyright (c) 2009 Promwad Innovation Company
- *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2416 specific register definitions
-*/
-
-#ifndef __ASM_ARCH_REGS_S3C2416_H
-#define __ASM_ARCH_REGS_S3C2416_H "s3c2416"
-
-#define S3C2416_SWRST		(S3C24XX_VA_CLKPWR + 0x44)
-#define S3C2416_SWRST_RESET	(0x533C2416)
-
-/* see regs-power.h for the other registers in the power block. */
-
-#endif	/* __ASM_ARCH_REGS_S3C2416_H */
-
-- 
1.7.10.4
