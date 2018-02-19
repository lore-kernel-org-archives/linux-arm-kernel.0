From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Mon, 19 Feb 2018 13:47:32 +0100
Subject: [PATCH v4 09/13] mfd: axp20x: add battery power supply cell for AXP813
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
Message-ID: <3aa781bcd28fe7ba6faaa85821952141351cf410.1519044068.git-series.quentin.schulz@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As axp20x-battery-power-supply now supports AXP813, add a cell for it.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index e5516aa..aaf2acb 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -888,6 +888,9 @@ static struct mfd_cell axp813_cells[] = {
 	}, {
 		.name			= "axp813-adc",
 		.of_compatible		= "x-powers,axp813-adc",
+	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp813-battery-power-supply",
 	},
 };
 
-- 
git-series 0.9.1
