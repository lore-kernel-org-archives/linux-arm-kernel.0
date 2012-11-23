From: rajanikanth.hv@stericsson.com (Rajanikanth H.V)
Date: Fri, 23 Nov 2012 09:44:31 +0530
Subject: [PATCH] mfd: ab8500: add static linkage for battery info
Message-ID: <1353644071-14142-1-git-send-email-rajanikanth.hv@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Rajanikanth H.V" <rajanikanth.hv@linaro.org>

enforce static linkage for battery attributes structures

this patch is against: "mfd-ab8500-add-devicetree-support-for-fuelgauge"

Signed-off-by: Rajanikanth H.V <rajanikanth.hv@linaro.org>
---
 drivers/power/ab8500_bmdata.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/ab8500_bmdata.c b/drivers/power/ab8500_bmdata.c
index ff8f055..db17930 100644
--- a/drivers/power/ab8500_bmdata.c
+++ b/drivers/power/ab8500_bmdata.c
@@ -143,7 +143,7 @@ static struct abx500_res_to_temp temp_tbl[] = {
  * Note that the batres_vs_temp table must be strictly sorted by falling
  * temperature values to work.
  */
-struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {
+static struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {
 	{ 40, 120},
 	{ 30, 135},
 	{ 20, 165},
@@ -157,7 +157,7 @@ struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {
  * Note that the batres_vs_temp table must be strictly sorted by falling
  * temperature values to work.
  */
-struct batres_vs_temp temp_to_batres_tbl_ext_thermistor[] = {
+static struct batres_vs_temp temp_to_batres_tbl_ext_thermistor[] = {
 	{ 60, 300},
 	{ 30, 300},
 	{ 20, 300},
@@ -168,7 +168,7 @@ struct batres_vs_temp temp_to_batres_tbl_ext_thermistor[] = {
 };
 
 /* battery resistance table for LI ION 9100 battery */
-struct batres_vs_temp temp_to_batres_tbl_9100[] = {
+static struct batres_vs_temp temp_to_batres_tbl_9100[] = {
 	{ 60, 180},
 	{ 30, 180},
 	{ 20, 180},
-- 
1.7.10.4
