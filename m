From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 18 Mar 2014 18:15:59 +0100
Subject: [PATCH v2 1/6] serial: s3c: Fix build of header without serial_core.h
 preinclusion
Message-ID: <1395162964-5916-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

serial_s3c.h uses upf_t which is defined in serial_core.h but does not
include that itself meaning that users which include serial_s3c.h by
itself don't build.

Signed-off-by: Mark Brown <broonie@linaro.org>
[t.figa: Moved inclusion under #ifndef __ASSEMBLY__ to fix mach-exynos.]
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 include/linux/serial_s3c.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index 907d9d1..e6fc956 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -233,6 +233,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/serial_core.h>
+
 /* configuration structure for per-machine configurations for the
  * serial port
  *
-- 
1.9.0
