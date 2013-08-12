From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 12 Aug 2013 14:44:07 +0530
Subject: [PATCH 9/9] clk: s3c64xx: Fix incorrect placement of __initdata
In-Reply-To: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1376298847-21828-9-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-s3c64xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
index eeda567..7d2c842 100644
--- a/drivers/clk/samsung/clk-s3c64xx.c
+++ b/drivers/clk/samsung/clk-s3c64xx.c
@@ -65,7 +65,7 @@ enum s3c64xx_plls {
  * List of controller registers to be saved and restored during
  * a suspend/resume cycle.
  */
-static __initdata unsigned long s3c64xx_clk_regs[] = {
+static unsigned long s3c64xx_clk_regs[] __initdata = {
 	APLL_LOCK,
 	MPLL_LOCK,
 	EPLL_LOCK,
@@ -82,7 +82,7 @@ static __initdata unsigned long s3c64xx_clk_regs[] = {
 	SCLK_GATE,
 };
 
-static __initdata unsigned long s3c6410_clk_regs[] = {
+static unsigned long s3c6410_clk_regs[] __initdata = {
 	CLK_SRC2,
 	MEM0_GATE,
 };
-- 
1.7.9.5
