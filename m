From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 26 Jul 2017 16:28:27 +0800
Subject: [PATCH v2 4/9] mfd: axp20x: use correct platform device id for many
 PEK
In-Reply-To: <20170726082832.16789-1-wens@csie.org>
References: <20170726082832.16789-1-wens@csie.org>
Message-ID: <20170726082832.16789-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

According to their datasheets, the AXP221, AXP223, AXP288, AXP803,
AXP809 and AXP813 PEK have different values for startup time bits from
the AXP20X, let's use the platform device id with the correct values.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index ec4271ca065c..336de66ca408 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -677,7 +677,7 @@ static struct mfd_cell axp20x_cells[] = {
 
 static struct mfd_cell axp221_cells[] = {
 	{
-		.name		= "axp20x-pek",
+		.name		= "axp221-pek",
 		.num_resources	= ARRAY_SIZE(axp22x_pek_resources),
 		.resources	= axp22x_pek_resources,
 	}, {
@@ -702,7 +702,7 @@ static struct mfd_cell axp221_cells[] = {
 
 static struct mfd_cell axp223_cells[] = {
 	{
-		.name			= "axp20x-pek",
+		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
 		.resources		= axp22x_pek_resources,
 	}, {
@@ -835,7 +835,7 @@ static struct mfd_cell axp288_cells[] = {
 		.resources = axp288_fuel_gauge_resources,
 	},
 	{
-		.name = "axp20x-pek",
+		.name = "axp221-pek",
 		.num_resources = ARRAY_SIZE(axp288_power_button_resources),
 		.resources = axp288_power_button_resources,
 	},
@@ -846,7 +846,7 @@ static struct mfd_cell axp288_cells[] = {
 
 static struct mfd_cell axp803_cells[] = {
 	{
-		.name			= "axp20x-pek",
+		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
 	},
@@ -862,7 +862,7 @@ static struct mfd_cell axp806_cells[] = {
 
 static struct mfd_cell axp809_cells[] = {
 	{
-		.name			= "axp20x-pek",
+		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp809_pek_resources),
 		.resources		= axp809_pek_resources,
 	}, {
@@ -873,7 +873,7 @@ static struct mfd_cell axp809_cells[] = {
 
 static struct mfd_cell axp813_cells[] = {
 	{
-		.name			= "axp20x-pek",
+		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
 	}
-- 
2.13.3
