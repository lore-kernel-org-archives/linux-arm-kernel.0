From: fkan@apm.com (Feng Kan)
Date: Wed, 22 Apr 2015 15:18:43 -0700
Subject: [PATCH V2 2/4] mailbox: xgene: add ACPI support for X-Gene mailbox
 driver
In-Reply-To: <1429741125-29156-1-git-send-email-fkan@apm.com>
References: <1429741125-29156-1-git-send-email-fkan@apm.com>
Message-ID: <1429741125-29156-3-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ACPI support for APM X-Gene mailbox driver.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/mailbox/mailbox-xgene-slimpro.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mailbox/mailbox-xgene-slimpro.c b/drivers/mailbox/mailbox-xgene-slimpro.c
index 49370e5..890f95b 100644
--- a/drivers/mailbox/mailbox-xgene-slimpro.c
+++ b/drivers/mailbox/mailbox-xgene-slimpro.c
@@ -18,6 +18,7 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  *
  */
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -240,6 +241,14 @@ static const struct of_device_id slimpro_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, slimpro_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id slimpro_acpi_ids[] = {
+	{"APMC0D01", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, slimpro_acpi_ids);
+#endif
+
 static struct platform_driver slimpro_mbox_driver = {
 	.probe	= slimpro_mbox_probe,
 	.remove = slimpro_mbox_remove,
@@ -247,6 +256,7 @@ static struct platform_driver slimpro_mbox_driver = {
 		.name = "xgene-slimpro-mbox",
 		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(slimpro_of_match),
+		.acpi_match_table = ACPI_PTR(slimpro_acpi_ids)
 	},
 };
 
-- 
1.9.1
