From: julien.grall@linaro.org (Julien Grall)
Date: Fri, 19 Jul 2013 14:09:59 +0100
Subject: [PATCH v2] xen/arm: enable PV control for ARM
Message-ID: <1374239399-2498-1-git-send-email-julien.grall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable power management from the toolstack for ARM guest.

Signed-off-by: Julien Grall <julien.grall@linaro.org>

---
    Changes in v2:
        - Don't compile xen/cpu_hotplug.o with ARM64
---
 drivers/xen/Makefile |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 2bf461a..b550a94 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,9 +1,8 @@
-ifneq ($(CONFIG_ARM),y)
-obj-y	+= manage.o
+ifneq ($(filter y, ($CONFIG_ARM) $(CONFIG_ARM64)),)
 obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
 endif
 obj-$(CONFIG_X86)			+= fallback.o
-obj-y	+= grant-table.o features.o events.o balloon.o time.o
+obj-y	+= grant-table.o features.o events.o balloon.o time.o manage.o
 obj-y	+= xenbus/
 
 nostackp := $(call cc-option, -fno-stack-protector)
-- 
1.7.10.4
