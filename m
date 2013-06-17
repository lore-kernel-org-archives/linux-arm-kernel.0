From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon, 17 Jun 2013 12:08:15 +0200
Subject: [PATCH] spi: pl022: remove unused ret and pins_state variables
Message-ID: <1371463695-21252-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removes the warnings:

drivers/spi/spi-pl022.c: In function 'pl022_suspend_resources':
drivers/spi/spi-pl022.c:2322:24: warning: unused variable 'pins_state' [-Wunused-variable]
drivers/spi/spi-pl022.c:2321:6: warning: unused variable 'ret' [-Wunused-variable]
drivers/spi/spi-pl022.c: In function 'pl022_resume_resources':
drivers/spi/spi-pl022.c:2334:6: warning: unused variable 'ret' [-Wunused-variable]

introduced in:

f1c9cf0 spi: pl022: use pinctrl PM helpers

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---

Hi Linus,

this is just a quick build warning fixup patch found while playing with
today's linux-next, should apply cleanly on pinctrl/for-next.

Thanks,
Fabio

 drivers/spi/spi-pl022.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 9652189..abef061 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2318,9 +2318,6 @@ pl022_remove(struct amba_device *adev)
  */
 static void pl022_suspend_resources(struct pl022 *pl022, bool runtime)
 {
-	int ret;
-	struct pinctrl_state *pins_state;
-
 	clk_disable(pl022->clk);
 
 	if (runtime)
@@ -2331,8 +2328,6 @@ static void pl022_suspend_resources(struct pl022 *pl022, bool runtime)
 
 static void pl022_resume_resources(struct pl022 *pl022, bool runtime)
 {
-	int ret;
-
 	/* First go to the default state */
 	pinctrl_pm_select_default_state(&pl022->adev->dev);
 	if (!runtime)
-- 
1.8.2
