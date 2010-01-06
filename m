From: roel.kluin@gmail.com (Roel Kluin)
Date: Wed, 06 Jan 2010 23:24:35 +0100
Subject: [PATCH] ARM: add missing parentheses
Message-ID: <4B450DA3.5010305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

`!' has a higher precedence than `&' so parentheses are required.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/arm/mach-s3c2440/mach-osiris-dvs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-osiris-dvs.c b/arch/arm/mach-s3c2440/mach-osiris-dvs.c
index ad2792d..0abcd38 100644
--- a/arch/arm/mach-s3c2440/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c2440/mach-osiris-dvs.c
@@ -77,8 +77,8 @@ static int osiris_dvs_notify(struct notifier_block *nb,
 		}
 		break;
 	case CPUFREQ_POSTCHANGE:
-		if (!old_dvs & new_dvs ||
-		    !cur_dvs & new_dvs) {
+		if (!(old_dvs & new_dvs) ||
+		    !(cur_dvs & new_dvs)) {
 			pr_debug("entering dvs\n");
 			cur_dvs = true;
 			gpio_set_value(OSIRIS_GPIO_DVS, 0);
