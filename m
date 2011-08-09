From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 09 Aug 2011 17:24:46 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix Section Mismatch in PWM backlight support
Message-ID: <1312878286-6300-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/dev-backlight.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-backlight.c b/arch/arm/plat-samsung/dev-backlight.c
index 3cedd4c..6955704 100644
--- a/arch/arm/plat-samsung/dev-backlight.c
+++ b/arch/arm/plat-samsung/dev-backlight.c
@@ -76,7 +76,7 @@ static struct platform_device samsung_dfl_bl_device __initdata = {
  * @gpio_info:	structure containing GPIO info for PWM timer
  * @bl_data:	structure containing Backlight control data
  */
-void samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
+void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
 	struct platform_pwm_backlight_data *bl_data)
 {
 	int ret = 0;
-- 
1.7.4.1
