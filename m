From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 17 Apr 2018 17:08:24 +0000
Subject: [PATCH] pinctrl: meson-axg: fix the range of aobus bank
Message-ID: <20180417170824.18670-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIOAO bank is range from GPIOAO_0 to GPIOAO_13.

Fixes: 83c566806a68 ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
Reported-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/pinctrl/meson/pinctrl-meson-axg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 4b91ff74779b..99a6ceac8e53 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -898,7 +898,7 @@ static struct meson_bank meson_axg_periphs_banks[] = {
 
 static struct meson_bank meson_axg_aobus_banks[] = {
 	/*   name    first      last      irq	pullen  pull    dir     out     in  */
-	BANK("AO",   GPIOAO_0,  GPIOAO_9, 0, 13, 0,  16,  0, 0,  0,  0,  0, 16,  1,  0),
+	BANK("AO",   GPIOAO_0,  GPIOAO_13, 0, 13, 0,  16,  0, 0,  0,  0,  0, 16,  1,  0),
 };
 
 static struct meson_pmx_bank meson_axg_periphs_pmx_banks[] = {
-- 
2.17.0
