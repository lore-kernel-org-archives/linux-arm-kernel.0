From: ameenali023@gmail.com (Ameen Ali)
Date: Fri, 13 Mar 2015 16:31:07 +0200
Subject: [PATCH 10/10] mach-osiris-dvs.c : use "&&" (not "&") with bool
 operands
Message-ID: <1426257067-5723-1-git-send-email-ameenali023@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

itwise AND ("&") was used
in logical expressions with operands having "bool" type. Replaced
bitwise AND operators with logical AND.

Signed-off-by : <AmeenAli023@gmail.com
---
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index ce2db23..e189836 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -70,16 +70,16 @@ static int osiris_dvs_notify(struct notifier_block *nb,
 
 	switch (val) {
 	case CPUFREQ_PRECHANGE:
-		if (old_dvs & !new_dvs ||
-		    cur_dvs & !new_dvs) {
+		if (old_dvs && !new_dvs ||
+		    cur_dvs && !new_dvs) {
 			pr_debug("%s: exiting dvs\n", __func__);
 			cur_dvs = false;
 			gpio_set_value(OSIRIS_GPIO_DVS, 1);
 		}
 		break;
 	case CPUFREQ_POSTCHANGE:
-		if (!old_dvs & new_dvs ||
-		    !cur_dvs & new_dvs) {
+		if (!old_dvs && new_dvs ||
+		    !cur_dvs && new_dvs) {
 			pr_debug("entering dvs\n");
 			cur_dvs = true;
 			gpio_set_value(OSIRIS_GPIO_DVS, 0);
-- 
2.1.0
