From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  9 Jan 2018 10:33:41 +0100
Subject: [PATCH v2 10/16] mfd: axp20x: probe axp20x_adc driver for AXP813
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
Message-ID: <6d52ef3dd2c7630517cb573f247b419d31c71e3a.1515486346.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the axp20x_adc driver probe with platform device id
"axp813-adc".

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/axp20x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index e0cbaea..d112414 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -884,7 +884,10 @@ static struct mfd_cell axp813_cells[] = {
 	}, {
 		.name			= "axp20x-gpio",
 		.of_compatible		= "x-powers,axp813-gpio",
-	}
+	}, {
+		.name			= "axp813-adc",
+		.of_compatible		= "x-powers,axp813-adc",
+	},
 };
 
 static struct axp20x_dev *axp20x_pm_power_off;
-- 
git-series 0.9.1
