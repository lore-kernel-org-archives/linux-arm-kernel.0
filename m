From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri,  1 Dec 2017 14:44:49 +0100
Subject: [PATCH v4 08/10] mfd: axp20x: add pinctrl cell for AXP813
In-Reply-To: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
Message-ID: <e0b4ce746c052b78f08dff54d0ad7ce7ebc611ab.1512135804.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As GPIO/pinctrl driver now supports AXP813, add a cell for it.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mfd/axp20x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 2468b43..d8c92fb 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -878,6 +878,9 @@ static struct mfd_cell axp813_cells[] = {
 		.resources		= axp803_pek_resources,
 	}, {
 		.name			= "axp20x-regulator",
+	}, {
+		.name			= "axp20x-gpio",
+		.of_compatible		= "x-powers,axp813-gpio",
 	}
 };
 
-- 
git-series 0.9.1
