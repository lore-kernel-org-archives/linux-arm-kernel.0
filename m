From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Jun 2015 14:46:04 +0100
Subject: [PATCH] ARM: kbuild: don't use generic mcs_spinlock.h header
Message-ID: <1434721564-8338-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We provide our own implementation of asm/mcs_spinlock.h, so there's no
need to ask for the (empty) generic version.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 3c4596d0ce6c..84e8945b861e 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -12,7 +12,6 @@ generic-y += irq_regs.h
 generic-y += kdebug.h
 generic-y += local.h
 generic-y += local64.h
-generic-y += mcs_spinlock.h
 generic-y += msgbuf.h
 generic-y += param.h
 generic-y += parport.h
-- 
2.1.4
