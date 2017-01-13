From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 Jan 2017 14:14:04 +0100
Subject: [PATCH v3 03/15] ARM: davinci: Don't rely on public mmc header to
 include interrupt.h
In-Reply-To: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1484313256-25993-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci board omapl138-hawk, depends on interrupt.h. Explicitly include
it instead of relying on the public mmc header host.h.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

I am seeking an ack for this change as following changes for mmc in the
series, has build-dependencies to it.

---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 41d5500..a3e7807 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/interrupt.h>
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/platform_data/gpio-davinci.h>
-- 
1.9.1
