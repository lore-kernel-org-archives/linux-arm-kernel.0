From: marek@goldelico.com (Marek Belisko)
Date: Tue, 10 Mar 2015 22:27:26 +0100
Subject: [PATCH v4 5/6] power: twl4030_madc_battery: Add of_twl4030_madc_match
 to MODULE_DEVICE_TABLE
In-Reply-To: <1426022847-30912-1-git-send-email-marek@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
Message-ID: <1426022847-30912-6-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When twl_4030_madc_battery is build as module, MODULE_DEVICE_TABLE allow
the module to be auto-loaded since the module will match the devices
instantiated from device tree.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/power/twl4030_madc_battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/twl4030_madc_battery.c
index 4bcb4a9..3e0005d 100644
--- a/drivers/power/twl4030_madc_battery.c
+++ b/drivers/power/twl4030_madc_battery.c
@@ -252,6 +252,8 @@ static const struct of_device_id of_twl4030_madc_match[] = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(of, of_twl4030_madc_match);
+
 #else
 static struct twl4030_madc_bat_platform_data *
 	twl4030_madc_dt_probe(struct platform_device *pdev)
-- 
1.9.1
