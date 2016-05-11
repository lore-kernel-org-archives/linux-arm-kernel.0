From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 May 2016 15:30:16 +0200
Subject: [PULL 23/29] irqchip/gic-v3: Prefix all pr_* messages by "GICv3: "
In-Reply-To: <1462973422-10021-1-git-send-email-christoffer.dall@linaro.org>
References: <1462973422-10021-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1462973422-10021-24-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Grall <julien.grall@arm.com>

Currently, most of the pr_* messages in the GICv3 driver don't have a
prefix.  Add one to make clear where the messages come from.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5b7d3c2..6dc6f03 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -15,6 +15,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#define pr_fmt(fmt)	"GICv3: " fmt
+
 #include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpu_pm.h>
-- 
2.1.2.330.g565301e.dirty
