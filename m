From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 25 Apr 2018 17:32:39 +0800
Subject: [PATCH v2 13/17] rtc: mt6397: cleanup header files to include
In-Reply-To: <cover.1524646231.git.sean.wang@mediatek.com>
References: <cover.1524646231.git.sean.wang@mediatek.com>
Message-ID: <ac254bb75a28a6a7c55557eedc9e466a5dbba075.1524646231.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Clean up those included header files by removing unreferenced ones,
add missing ones the driver explicitly depends on and finally list
all #includes in alphabetical order.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 4c5cdaa..3672d622 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -12,17 +12,14 @@
 * GNU General Public License for more details.
 */
 
-#include <linux/delay.h>
-#include <linux/init.h>
+#include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/mt6397/core.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
-#include <linux/platform_device.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/rtc.h>
 
 static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
-- 
2.7.4
