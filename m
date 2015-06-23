From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 23 Jun 2015 16:09:26 +0200
Subject: [PATCH 8/9] drivers: clk: st: Rename st_pll3200c32_407_c0_x into
 st_pll3200c32_cx_x
In-Reply-To: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1435068567-30995-9-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a generic name for this kind of PLL

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 drivers/clk/st/clkgen-fsyn.c |  8 ++++----
 drivers/clk/st/clkgen-pll.c  | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index d9eb2e1..a2239cf 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -306,7 +306,7 @@ static const struct clkgen_quadfs_data st_fs660c32_F_416 = {
 	.get_rate	= clk_fs660c32_dig_get_rate,
 };
 
-static const struct clkgen_quadfs_data st_fs660c32_C_407 = {
+static const struct clkgen_quadfs_data st_fs660c32_C = {
 	.nrst_present = true,
 	.nrst	= { CLKGEN_FIELD(0x2f0, 0x1, 0),
 		    CLKGEN_FIELD(0x2f0, 0x1, 1),
@@ -349,7 +349,7 @@ static const struct clkgen_quadfs_data st_fs660c32_C_407 = {
 	.get_rate	= clk_fs660c32_dig_get_rate,
 };
 
-static const struct clkgen_quadfs_data st_fs660c32_D_407 = {
+static const struct clkgen_quadfs_data st_fs660c32_D = {
 	.nrst_present = true,
 	.nrst	= { CLKGEN_FIELD(0x2a0, 0x1, 0),
 		    CLKGEN_FIELD(0x2a0, 0x1, 1),
@@ -1076,11 +1076,11 @@ static const struct of_device_id quadfs_of_match[] = {
 	},
 	{
 		.compatible = "st,stih407-quadfs660-C",
-		.data = &st_fs660c32_C_407
+		.data = &st_fs660c32_C
 	},
 	{
 		.compatible = "st,stih407-quadfs660-D",
-		.data = &st_fs660c32_D_407
+		.data = &st_fs660c32_D
 	},
 	{}
 };
diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 72d1c27..6742b3d 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -192,7 +192,7 @@ static const struct clkgen_pll_data st_pll3200c32_407_a0 = {
 	.ops		= &stm_pll3200c32_ops,
 };
 
-static const struct clkgen_pll_data st_pll3200c32_407_c0_0 = {
+static const struct clkgen_pll_data st_pll3200c32_cx_0 = {
 	/* 407 C0 PLL0 */
 	.pdn_status	= CLKGEN_FIELD(0x2a0,	0x1,			8),
 	.locked_status	= CLKGEN_FIELD(0x2a0,	0x1,			24),
@@ -204,7 +204,7 @@ static const struct clkgen_pll_data st_pll3200c32_407_c0_0 = {
 	.ops		= &stm_pll3200c32_ops,
 };
 
-static const struct clkgen_pll_data st_pll3200c32_407_c0_1 = {
+static const struct clkgen_pll_data st_pll3200c32_cx_1 = {
 	/* 407 C0 PLL1 */
 	.pdn_status	= CLKGEN_FIELD(0x2c8,	0x1,			8),
 	.locked_status	= CLKGEN_FIELD(0x2c8,	0x1,			24),
@@ -623,12 +623,12 @@ static const struct of_device_id c32_pll_of_match[] = {
 		.data = &st_pll3200c32_407_a0,
 	},
 	{
-		.compatible = "st,stih407-plls-c32-c0_0",
-		.data = &st_pll3200c32_407_c0_0,
+		.compatible = "st,plls-c32-cx_0",
+		.data = &st_pll3200c32_cx_0,
 	},
 	{
-		.compatible = "st,stih407-plls-c32-c0_1",
-		.data = &st_pll3200c32_407_c0_1,
+		.compatible = "st,plls-c32-cx_1",
+		.data = &st_pll3200c32_cx_1,
 	},
 	{
 		.compatible = "st,stih407-plls-c32-a9",
-- 
1.9.1
