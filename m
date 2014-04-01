From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Tue,  1 Apr 2014 17:02:55 +0300
Subject: [PATCHv3 4/5] net: rfkill: gpio: add ACPI IDs for a Broadcom
 bluetooth chip
In-Reply-To: <1396360976-28657-1-git-send-email-heikki.krogerus@linux.intel.com>
References: <1396360976-28657-1-git-send-email-heikki.krogerus@linux.intel.com>
Message-ID: <1396360976-28657-5-git-send-email-heikki.krogerus@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds ACPI IDs for Broadcom bluetooth chip BCM43241 used
on various Baytrail based boards such as Lenovo Miix 2 and
Asus Transformer Book T100TA.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 net/rfkill/rfkill-gpio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index fec3dbf..436bffb 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -171,11 +171,16 @@ static int rfkill_gpio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id rfkill_acpi_match[] = {
+	{ "BCM2E1A", RFKILL_TYPE_BLUETOOTH },
+	{ "BCM2E39", RFKILL_TYPE_BLUETOOTH },
+	{ "BCM2E3D", RFKILL_TYPE_BLUETOOTH },
 	{ "BCM4752", RFKILL_TYPE_GPS },
 	{ "LNV4752", RFKILL_TYPE_GPS },
 	{ },
 };
+#endif
 
 static struct platform_driver rfkill_gpio_driver = {
 	.probe = rfkill_gpio_probe,
-- 
1.9.1
