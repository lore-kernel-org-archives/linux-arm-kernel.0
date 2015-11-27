From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 27 Nov 2015 14:43:26 +0800
Subject: [PATCH v5 5/9] mfd: axp20x: Whitespace,
 open parenthesis alignment code style fixes
In-Reply-To: <1448606610-32647-1-git-send-email-wens@csie.org>
References: <1448606610-32647-1-git-send-email-wens@csie.org>
Message-ID: <1448606610-32647-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes some leftover code style issues in the axp20x core.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 631ad64ddf69..54a00168da26 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -591,14 +591,14 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 			dev_err(dev, "Unable to match OF ID\n");
 			return -ENODEV;
 		}
-		axp20x->variant = (long) of_id->data;
+		axp20x->variant = (long)of_id->data;
 	} else {
 		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
 		if (!acpi_id || !acpi_id->driver_data) {
 			dev_err(dev, "Unable to match ACPI ID and data\n");
 			return -ENODEV;
 		}
-		axp20x->variant = (long) acpi_id->driver_data;
+		axp20x->variant = (long)acpi_id->driver_data;
 	}
 
 	switch (axp20x->variant) {
@@ -632,7 +632,7 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		return -EINVAL;
 	}
 	dev_info(dev, "AXP20x variant %s found\n",
-		axp20x_model_names[axp20x->variant]);
+		 axp20x_model_names[axp20x->variant]);
 
 	return 0;
 }
@@ -652,7 +652,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 	}
 
 	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
-			axp20x->nr_cells, NULL, 0, NULL);
+			      axp20x->nr_cells, NULL, 0, NULL);
 
 	if (ret) {
 		dev_err(axp20x->dev, "failed to add MFD devices: %d\n", ret);
-- 
2.6.2
