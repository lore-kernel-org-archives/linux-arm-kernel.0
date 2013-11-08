From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Nov 2013 18:37:11 +0000
Subject: [PATCH 8/9] ARM: add test for as supporting '.inst'
In-Reply-To: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1383935832-20865-9-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a test for the assembler supporting .inst and then defining
ARM_HAVE_INST for any position where this is needed.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0069697..d556a52 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -36,6 +36,8 @@ MMUEXT		:= -nommu
 KBUILD_CFLAGS	+= $(call cc-option,-mno-unaligned-access)
 endif
 
+KBUILD_CFLAGS	+= $(call as-instr,.inst 0x0,-DARM_HAVE_INST)
+
 ifeq ($(CONFIG_FRAME_POINTER),y)
 KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
 endif
-- 
1.8.4.rc3
