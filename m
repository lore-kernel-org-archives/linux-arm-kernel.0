From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Thu, 13 Mar 2014 22:46:57 +0000
Subject: [PATCH v2 04/15] lib: add fdt_empty_tree.c
In-Reply-To: <1394750828-16351-1-git-send-email-leif.lindholm@linaro.org>
References: <1394750828-16351-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1394750828-16351-5-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

CONFIG_LIBFDT support does not include fdt_empty_tree.c which is
needed by arm64 EFI stub. Add it to libfdt_files.

Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 lib/Makefile         |    3 ++-
 lib/fdt_empty_tree.c |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 lib/fdt_empty_tree.c

diff --git a/lib/Makefile b/lib/Makefile
index 48140e3..befe555 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -147,7 +147,8 @@ obj-$(CONFIG_GENERIC_NET_UTILS) += net_utils.o
 
 obj-$(CONFIG_STMP_DEVICE) += stmp_device.o
 
-libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o
+libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
+	       fdt_empty_tree.o
 $(foreach file, $(libfdt_files), \
 	$(eval CFLAGS_$(file) = -I$(src)/../scripts/dtc/libfdt))
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
diff --git a/lib/fdt_empty_tree.c b/lib/fdt_empty_tree.c
new file mode 100644
index 0000000..5d30c58
--- /dev/null
+++ b/lib/fdt_empty_tree.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../scripts/dtc/libfdt/fdt_empty_tree.c"
-- 
1.7.10.4
