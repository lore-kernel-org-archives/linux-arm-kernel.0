From: wladislav.wiebe@nokia.com (Wiebe, Wladislav (Nokia - DE/Ulm))
Date: Fri, 2 Sep 2016 09:17:58 +0000
Subject: [PATCH] ARM: fix linker call for ARM_MODULE_PLTS
Message-ID: <HE1PR07MB14835C6A5F6AA3A905E40018FAE50@HE1PR07MB1483.eurprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

module.lds script doesn't get called when
CONFIG_ARM_MODULE_PLTS is enabled.
Use KBUILD_LDFLAGS_MODULE to fix it.

Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 61f6ccc..01c6025 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -20,7 +20,7 @@ LDFLAGS_MODULE	+= --be8
 endif
 
 ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
-LDFLAGS_MODULE	+= -T $(srctree)/arch/arm/kernel/module.lds
+KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm/kernel/module.lds
 endif
 
 OBJCOPYFLAGS	:=-O binary -R .comment -S
-- 
1.7.12.4
