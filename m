From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 2 Nov 2016 09:32:57 -0500
Subject: [PATCHv3 3/4] mfd: altr-a10sr: Add Arria10 SR Monitor
In-Reply-To: <1478097178-24341-1-git-send-email-tthayer@opensource.altera.com>
References: <1478097178-24341-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1478097178-24341-4-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the Altera Arria10 DevKit System Resource Monitor functionality
to the MFD device.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2  Change from -mon to -monitor for clarity
v3  Shorten driver name (remove altr_).
---
 drivers/mfd/altera-a10sr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/altera-a10sr.c b/drivers/mfd/altera-a10sr.c
index 06e1f7f..2ddf235 100644
--- a/drivers/mfd/altera-a10sr.c
+++ b/drivers/mfd/altera-a10sr.c
@@ -30,9 +30,13 @@
 
 static const struct mfd_cell altr_a10sr_subdev_info[] = {
 	{
-		.name = "altr_a10sr_gpio",
+		.name = "a10sr_gpio",
 		.of_compatible = "altr,a10sr-gpio",
 	},
+	{
+		.name = "a10sr_monitor",
+		.of_compatible = "altr,a10sr-monitor",
+	},
 };
 
 static bool altr_a10sr_reg_readable(struct device *dev, unsigned int reg)
-- 
1.9.1
