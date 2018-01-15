From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 15 Jan 2018 11:33:40 +0100
Subject: [PATCH v3 06/16] mfd: axp20x: make AXP209/22x cells probe their ADC
 via DT
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
Message-ID: <8901f920fb8d84f8bf0cb2832f560c78bffc0392.1516012352.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes AXP209 and AXP22x ADCs probe first via DT and then by
fallback via platform.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/axp20x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index e94c72c..1977a03 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -660,6 +660,7 @@ static struct mfd_cell axp20x_cells[] = {
 		.name		= "axp20x-regulator",
 	}, {
 		.name		= "axp20x-adc",
+		.of_compatible	= "x-powers,axp209-adc",
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp209-battery-power-supply",
@@ -684,7 +685,8 @@ static struct mfd_cell axp221_cells[] = {
 	}, {
 		.name		= "axp20x-regulator",
 	}, {
-		.name		= "axp22x-adc"
+		.name		= "axp22x-adc",
+		.of_compatible	= "x-powers,axp221-adc",
 	}, {
 		.name		= "axp20x-ac-power-supply",
 		.of_compatible	= "x-powers,axp221-ac-power-supply",
@@ -708,6 +710,7 @@ static struct mfd_cell axp223_cells[] = {
 		.resources		= axp22x_pek_resources,
 	}, {
 		.name		= "axp22x-adc",
+		.of_compatible	= "x-powers,axp221-adc",
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp221-battery-power-supply",
-- 
git-series 0.9.1
