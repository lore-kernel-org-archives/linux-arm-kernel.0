From: julien.grall@arm.com (Julien Grall)
Date: Mon, 11 Apr 2016 16:32:55 +0100
Subject: [PATCH v6 05/10] irqchip/gic-v3: Prefix all pr_* messages by "GICv3: "
In-Reply-To: <1460388780-914-1-git-send-email-julien.grall@arm.com>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
Message-ID: <1460388780-914-6-git-send-email-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, most of the pr_* messages in the GICv3 driver don't have a
prefix.  Add one to make clear where the messages come from.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v6:
        - Patch added
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
1.9.1
