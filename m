From: aford173@gmail.com (Adam Ford)
Date: Tue, 30 Oct 2018 09:55:07 -0500
Subject: [PATCH V2] regulator: pfuze100-regulator: add coin support to PF0100
Message-ID: <20181030145507.10462-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver currently supports coin cell / super cap charging, so
this patch extends it to support PF0100.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Rebase from correct branch.
V1:  Ooops, sorry about the noise.

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index dd41a9bb3f5c..df5df1c495ad 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -370,6 +370,7 @@ static struct pfuze_regulator pfuze100_regulators[] = {
 	PFUZE100_VGEN_REG(PFUZE100, VGEN4, PFUZE100_VGEN4VOL, 1800000, 3300000, 100000),
 	PFUZE100_VGEN_REG(PFUZE100, VGEN5, PFUZE100_VGEN5VOL, 1800000, 3300000, 100000),
 	PFUZE100_VGEN_REG(PFUZE100, VGEN6, PFUZE100_VGEN6VOL, 1800000, 3300000, 100000),
+	PFUZE100_COIN_REG(PFUZE100, COIN, PFUZE100_COINVOL, 0x7, pfuze100_coin),
 };
 
 static struct pfuze_regulator pfuze200_regulators[] = {
@@ -436,6 +437,7 @@ static struct of_regulator_match pfuze100_matches[] = {
 	{ .name = "vgen4",	},
 	{ .name = "vgen5",	},
 	{ .name = "vgen6",	},
+	{ .name = "coin",	},
 };
 
 /* PFUZE200 */
diff --git a/include/linux/regulator/pfuze100.h b/include/linux/regulator/pfuze100.h
index cb5aecd40f07..331d7d940c7a 100644
--- a/include/linux/regulator/pfuze100.h
+++ b/include/linux/regulator/pfuze100.h
@@ -33,7 +33,8 @@
 #define PFUZE100_VGEN4		12
 #define PFUZE100_VGEN5		13
 #define PFUZE100_VGEN6		14
-#define PFUZE100_MAX_REGULATOR	15
+#define PFUZE100_COIN		15
+#define PFUZE100_MAX_REGULATOR	16
 
 #define PFUZE200_SW1AB		0
 #define PFUZE200_SW2		1
-- 
2.17.1
