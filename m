From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  4 Dec 2017 15:12:49 +0100
Subject: [PATCH 3/8] mfd: axp20x: probe axp20x_adc driver for AXP813
In-Reply-To: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
Message-ID: <302c93023d8c4a54cafe321d912df484e39727b7.1512396054.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the axp20x_adc driver probe with platform device id
"axp813-adc".

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/axp20x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 2468b43..42e54d1 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -878,7 +878,9 @@ static struct mfd_cell axp813_cells[] = {
 		.resources		= axp803_pek_resources,
 	}, {
 		.name			= "axp20x-regulator",
-	}
+	}, {
+		.name			= "axp813-adc",
+	},
 };
 
 static struct axp20x_dev *axp20x_pm_power_off;
-- 
git-series 0.9.1
