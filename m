From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  5 Oct 2016 17:51:12 +0200
Subject: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
In-Reply-To: <20161005155112.13774-1-hdegoede@redhat.com>
References: <20161005155112.13774-1-hdegoede@redhat.com>
Message-ID: <20161005155112.13774-2-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c subsys does not load modules by compatible, only by
i2c-id, with e.g. a modalias of: "i2c:axp209".

Populate the axp20x_i2c_id[] table with supported ids, so that
module auto-loading will work.

Reported-by: Dennis Gilmore <dennis@ausil.us>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/axp20x-i2c.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index b1b8658..d35a5fe 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -69,10 +69,11 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
 
-/*
- * This is useless for OF-enabled devices, but it is needed by I2C subsystem
- */
 static const struct i2c_device_id axp20x_i2c_id[] = {
+	{ "axp152", 0 },
+	{ "axp202", 0 },
+	{ "axp209", 0 },
+	{ "axp221", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
-- 
2.9.3
