From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:14 +0100
Subject: [PATCH 01/69] clocksource/drivers/mtk_timer: Add pr_fmt define
In-Reply-To: <5672CB9E.7090707@linaro.org>
References: <5672CB9E.7090707@linaro.org>
Message-ID: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexey Klimov <alexey.klimov@linaro.org>

It's a bit unclear what subsystem/driver emits some messages to dmesg in
the function mtk_init_timer(). Use pr_fmt to auto-prefix the messages
appropriately.

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/mtk_timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
index fbfc746..8f99cd7 100644
--- a/drivers/clocksource/mtk_timer.c
+++ b/drivers/clocksource/mtk_timer.c
@@ -16,6 +16,8 @@
  * GNU General Public License for more details.
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
-- 
1.9.1
