From: jtzhou@marvell.com (Jett.Zhou)
Date: Wed, 30 Nov 2011 14:32:54 +0800
Subject: [V3 6/6] ARM: sa1100: fix build error
Message-ID: <1322634774-4667-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm-eabi-4.4.3-ld:--defsym zreladdr=: syntax error
make[2]: *** [arch/arm/boot/compressed/vmlinux] Error 1
make[1]: *** [arch/arm/boot/compressed/vmlinux] Error 2
make: *** [uImage] Error 2

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 arch/arm/mach-sa1100/Makefile.boot |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/Makefile.boot b/arch/arm/mach-sa1100/Makefile.boot
index 5a616f6..f7951aa 100644
--- a/arch/arm/mach-sa1100/Makefile.boot
+++ b/arch/arm/mach-sa1100/Makefile.boot
@@ -1,5 +1,5 @@
-ifeq ($(CONFIG_ARCH_SA1100),y)
-   zreladdr-$(CONFIG_SA1111)		+= 0xc0208000
+ifeq ($(CONFIG_SA1111),y)
+   zreladdr-y	+= 0xc0208000
 else
    zreladdr-y	+= 0xc0008000
 endif
-- 
1.7.0.4
