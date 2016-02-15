From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 15 Feb 2016 18:31:22 +0800
Subject: [PATCH v2 04/10] regulator: axp20x: Use of_match name as default
 regulator name
In-Reply-To: <1455532288-30870-1-git-send-email-wens@csie.org>
References: <1455532288-30870-1-git-send-email-wens@csie.org>
Message-ID: <1455532288-30870-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originally the helper macros used uppercase regulator names, which
are primarily used to expand to the regulator ID enum, as the default
names. This is aestheticly unpleasent.

Since the of_match bits are the same, just lowercase, use that as the
default names instead.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/regulator/axp20x-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 81f25383f2d5..40cd894e4df5 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -39,7 +39,7 @@
 #define AXP_DESC_IO(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
 		    _vmask, _ereg, _emask, _enable_val, _disable_val)		\
 	[_family##_##_id] = {							\
-		.name		= #_id,						\
+		.name		= (_match),					\
 		.supply_name	= (_supply),					\
 		.of_match	= of_match_ptr(_match),				\
 		.regulators_node = of_match_ptr("regulators"),			\
@@ -61,7 +61,7 @@
 #define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
 		 _vmask, _ereg, _emask) 					\
 	[_family##_##_id] = {							\
-		.name		= #_id,						\
+		.name		= (_match),					\
 		.supply_name	= (_supply),					\
 		.of_match	= of_match_ptr(_match),				\
 		.regulators_node = of_match_ptr("regulators"),			\
@@ -80,7 +80,7 @@
 
 #define AXP_DESC_SW(_family, _id, _match, _supply, _ereg, _emask)		\
 	[_family##_##_id] = {							\
-		.name		= #_id,						\
+		.name		= (_match),					\
 		.supply_name	= (_supply),					\
 		.of_match	= of_match_ptr(_match),				\
 		.regulators_node = of_match_ptr("regulators"),			\
@@ -94,7 +94,7 @@
 
 #define AXP_DESC_FIXED(_family, _id, _match, _supply, _volt)			\
 	[_family##_##_id] = {							\
-		.name		= #_id,						\
+		.name		= (_match),					\
 		.supply_name	= (_supply),					\
 		.of_match	= of_match_ptr(_match),				\
 		.regulators_node = of_match_ptr("regulators"),			\
@@ -109,7 +109,7 @@
 #define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_voltages,	\
 			_vreg, _vmask, _ereg, _emask)				\
 	[_family##_##_id] = {							\
-		.name		= #_id,						\
+		.name		= (_match),					\
 		.supply_name	= (_supply),					\
 		.of_match	= of_match_ptr(_match),				\
 		.regulators_node = of_match_ptr("regulators"),			\
-- 
2.7.0
