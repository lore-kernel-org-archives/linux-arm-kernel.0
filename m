From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Mon, 19 Feb 2018 13:47:26 +0100
Subject: [PATCH v4 03/13] mfd: axp20x: make AXP209/22x cells probe their ADC
 via DT
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
Message-ID: <d9e6a3d2a2a8d6d29360183c94fe63d8dbaedae8.1519044068.git-series.quentin.schulz@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes AXP209 and AXP22x ADCs probe first via DT and then by
fallback via platform.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
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
