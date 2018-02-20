From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Feb 2018 17:12:25 +0800
Subject: [RFC PATCH] power: supply: axp20x_battery: axp209_data can be static
In-Reply-To: <52f68b8ed9452d643d9156a849014c9d0eb4404b.1519044068.git-series.quentin.schulz@bootlin.com>
References: <52f68b8ed9452d643d9156a849014c9d0eb4404b.1519044068.git-series.quentin.schulz@bootlin.com>
Message-ID: <20180220091225.GA95450@cairo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: 94767270f0b0 ("power: supply: axp20x_battery: use data struct for variant specific code")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 axp20x_battery.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 099e785..04a0d91 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -476,14 +476,14 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
 	.set_property = axp20x_battery_set_prop,
 };
 
-const struct axp_data axp209_data = {
+static const struct axp_data axp209_data = {
 	.ccc_scale = 100000,
 	.ccc_offset = 300000,
 	.get_max_voltage = axp20x_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
 };
 
-const struct axp_data axp221_data = {
+static const struct axp_data axp221_data = {
 	.ccc_scale = 150000,
 	.ccc_offset = 300000,
 	.has_fg_valid = true,
