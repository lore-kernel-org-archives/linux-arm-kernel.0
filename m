From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 28 Jun 2014 15:42:23 +0100
Subject: [PATCH] ARM: add eabi version
Message-ID: <E1X0tpf-0001dO-5k@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that we specify the EABI version for EABI builds, otherwise we're
left to the toolchain's whims for this feature.  Adding -meabi=5 sets
the EABI version in the object files to 5, and adds the additional tag
information to the aeabi section.

This is required for the upcoming VDSO support.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5964ff1a3c32..f5c5a92edbe1 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -96,7 +96,7 @@ tune-$(CONFIG_CPU_V6K)		=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
 tune-y := $(tune-y)
 
 ifeq ($(CONFIG_AEABI),y)
-CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp
+CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp -Wa,-meabi=5
 else
 CFLAGS_ABI	:=$(call cc-option,-mapcs-32,-mabi=apcs-gnu) $(call cc-option,-mno-thumb-interwork,)
 endif
-- 
1.8.3.1
