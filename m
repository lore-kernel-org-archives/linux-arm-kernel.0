From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  4 Dec 2017 15:12:52 +0100
Subject: [PATCH 6/8] mfd: axp20x: add battery power supply cell for AXP813
In-Reply-To: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
Message-ID: <9b5e9ed623165d0586f086343a7c67bc5c18bbb5.1512396054.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As axp20x-battery-power-supply now supports AXP813, add a cell for it.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/axp20x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 42e54d1..7566358 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -880,6 +880,9 @@ static struct mfd_cell axp813_cells[] = {
 		.name			= "axp20x-regulator",
 	}, {
 		.name			= "axp813-adc",
+	}, {
+		.name			= "axp20x-battery-power-supply",
+		.of_compatible		= "x-powers,axp813-battery-power-supply",
 	},
 };
 
-- 
git-series 0.9.1
