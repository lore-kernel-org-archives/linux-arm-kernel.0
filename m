From: julien.grall@linaro.org (Julien Grall)
Date: Tue, 23 Jul 2013 16:21:28 +0100
Subject: [PATCH v5] xen/arm: enable PV control for ARM
Message-ID: <1374592888-5520-1-git-send-email-julien.grall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable lifecyle management (reboot, shutdown...) from the toolstack
for ARM guest.

Signed-off-by: Julien Grall <julien.grall@linaro.org>

---
    Changes in v5:
        - Rework commit message
    Changes in v4:
        - Divide the patch in 2 distinct parts
    Changes in v3:
        - Fix condition to compile cpu_hotplug.o
    Changes in v2:
        - Don't compile xen/cpu_hotplug.o with ARM64
---
 drivers/xen/Makefile |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index a609353..f185e8d 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,9 +1,8 @@
 ifeq ($(filter y, $(CONFIG_ARM) $(CONFIG_ARM64)),)
-obj-y	+= manage.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
 endif
 obj-$(CONFIG_X86)			+= fallback.o
-obj-y	+= grant-table.o features.o events.o balloon.o time.o
+obj-y	+= grant-table.o features.o events.o balloon.o time.o manage.o
 obj-y	+= xenbus/
 
 nostackp := $(call cc-option, -fno-stack-protector)
-- 
1.7.10.4
