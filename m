From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 21 Dec 2011 23:00:45 +0800
Subject: [PATCH 2/4] regulator: mc13892: remove the unnecessary prefix from
 regulator name
In-Reply-To: <1324479647-4580-1-git-send-email-shawn.guo@linaro.org>
References: <1324479647-4580-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1324479647-4580-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not really necessary to add a prefix 'MC13892__' for each mc13892
regulator name, since the chip must have been identified as mc13892
when we look at the regulator name.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/regulator/mc13xxx.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mc13xxx.h b/drivers/regulator/mc13xxx.h
index 2775826..75e3832 100644
--- a/drivers/regulator/mc13xxx.h
+++ b/drivers/regulator/mc13xxx.h
@@ -48,7 +48,7 @@ extern struct regulator_ops mc13xxx_fixed_regulator_ops;
 #define MC13xxx_DEFINE(prefix, _name, _reg, _vsel_reg, _voltages, _ops)	\
 	[prefix ## _name] = {				\
 		.desc = {						\
-			.name = #prefix "_" #_name,			\
+			.name = #_name,					\
 			.n_voltages = ARRAY_SIZE(_voltages),		\
 			.ops = &_ops,			\
 			.type = REGULATOR_VOLTAGE,			\
@@ -66,7 +66,7 @@ extern struct regulator_ops mc13xxx_fixed_regulator_ops;
 #define MC13xxx_FIXED_DEFINE(prefix, _name, _reg, _voltages, _ops)	\
 	[prefix ## _name] = {				\
 		.desc = {						\
-			.name = #prefix "_" #_name,			\
+			.name = #_name,					\
 			.n_voltages = ARRAY_SIZE(_voltages),		\
 			.ops = &_ops,		\
 			.type = REGULATOR_VOLTAGE,			\
@@ -81,7 +81,7 @@ extern struct regulator_ops mc13xxx_fixed_regulator_ops;
 #define MC13xxx_GPO_DEFINE(prefix, _name, _reg,  _voltages, _ops)	\
 	[prefix ## _name] = {				\
 		.desc = {						\
-			.name = #prefix "_" #_name,			\
+			.name = #_name,					\
 			.n_voltages = ARRAY_SIZE(_voltages),		\
 			.ops = &_ops,		\
 			.type = REGULATOR_VOLTAGE,			\
-- 
1.7.4.1
