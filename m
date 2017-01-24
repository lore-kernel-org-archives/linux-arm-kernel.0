From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 24 Jan 2017 17:59:20 +0100
Subject: [PATCH] regulator: pfuze100: add supply name to regulators
Message-ID: <20170124165920.16309-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The devicetree binding states that the regulators are described by the
generic regulator binding, so the input supply can just use the generic
"vin" name.

This allows to attach the regulators to their supplies, making the
regulator tree more useful.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/regulator/pfuze100-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index cb18b5c4f2db..94fbfa5c6de1 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -164,6 +164,7 @@ static struct regulator_ops pfuze100_swb_regulator_ops = {
 	[_chip ## _ ## _name] = {	\
 		.desc = {	\
 			.name = #_name,	\
+			.supply_name = "vin",	\
 			.n_voltages = 1,	\
 			.ops = &pfuze100_fixed_regulator_ops,	\
 			.type = REGULATOR_VOLTAGE,	\
@@ -179,6 +180,7 @@ static struct regulator_ops pfuze100_swb_regulator_ops = {
 	[_chip ## _ ## _name] = {	\
 		.desc = {	\
 			.name = #_name,\
+			.supply_name = "vin",	\
 			.n_voltages = ((max) - (min)) / (step) + 1,	\
 			.ops = &pfuze100_sw_regulator_ops,	\
 			.type = REGULATOR_VOLTAGE,	\
@@ -197,6 +199,7 @@ static struct regulator_ops pfuze100_swb_regulator_ops = {
 	[_chip ## _ ##  _name] = {	\
 		.desc = {	\
 			.name = #_name,	\
+			.supply_name = "vin",	\
 			.n_voltages = ARRAY_SIZE(voltages),	\
 			.ops = &pfuze100_swb_regulator_ops,	\
 			.type = REGULATOR_VOLTAGE,	\
@@ -214,6 +217,7 @@ static struct regulator_ops pfuze100_swb_regulator_ops = {
 	[_chip ## _ ## _name] = {	\
 		.desc = {	\
 			.name = #_name,	\
+			.supply_name = "vin",	\
 			.n_voltages = ((max) - (min)) / (step) + 1,	\
 			.ops = &pfuze100_ldo_regulator_ops,	\
 			.type = REGULATOR_VOLTAGE,	\
@@ -233,6 +237,7 @@ static struct regulator_ops pfuze100_swb_regulator_ops = {
 #define PFUZE3000_VCC_REG(_chip, _name, base, min, max, step)	{	\
 	.desc = {	\
 		.name = #_name,	\
+		.supply_name = "vin",	\
 		.n_voltages = ((max) - (min)) / (step) + 1,	\
 		.ops = &pfuze100_ldo_regulator_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
@@ -253,6 +258,7 @@ static struct regulator_ops pfuze100_swb_regulator_ops = {
 #define PFUZE3000_SW2_REG(_chip, _name, base, min, max, step)	{	\
 	.desc = {	\
 		.name = #_name,\
+		.supply_name = "vin",	\
 		.n_voltages = ((max) - (min)) / (step) + 1,	\
 		.ops = &pfuze100_sw_regulator_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
@@ -270,6 +276,7 @@ static struct regulator_ops pfuze100_swb_regulator_ops = {
 #define PFUZE3000_SW3_REG(_chip, _name, base, min, max, step)	{	\
 	.desc = {	\
 		.name = #_name,\
+		.supply_name = "vin",	\
 		.n_voltages = ((max) - (min)) / (step) + 1,	\
 		.ops = &pfuze100_sw_regulator_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
-- 
2.11.0
