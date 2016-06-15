From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 15 Jun 2016 17:18:06 +0900
Subject: [PATCH 2/2] pinctrl: uniphier: fix meaningless drive control offsets
In-Reply-To: <1465978686-28578-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465978686-28578-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1465978686-28578-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are input-only pins.  They do not support drive controlling
in the first place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 8c61493..002bd6e 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -138,7 +138,7 @@ static const struct pinctrl_pin_desc uniphier_pro4_pins[] = {
 			     38, UNIPHIER_PIN_DRV_1BIT,
 			     38, UNIPHIER_PIN_PULL_DOWN),
 	UNIPHIER_PINCTRL_PIN(39, "BOOTSWAP", UNIPHIER_PIN_IECTRL_NONE,
-			     39, UNIPHIER_PIN_DRV_NONE,
+			     -1, UNIPHIER_PIN_DRV_NONE,
 			     39, UNIPHIER_PIN_PULL_UP),
 	UNIPHIER_PINCTRL_PIN(40, "NFD0", UNIPHIER_PIN_IECTRL_NONE,
 			     2, UNIPHIER_PIN_DRV_2BIT,
@@ -639,7 +639,7 @@ static const struct pinctrl_pin_desc uniphier_pro4_pins[] = {
 			     191, UNIPHIER_PIN_DRV_1BIT,
 			     191, UNIPHIER_PIN_PULL_DOWN),
 	UNIPHIER_PINCTRL_PIN(206, "CLK54I", UNIPHIER_PIN_IECTRL_NONE,
-			     192, UNIPHIER_PIN_DRV_NONE,
+			     -1, UNIPHIER_PIN_DRV_NONE,
 			     192, UNIPHIER_PIN_PULL_DOWN),
 	UNIPHIER_PINCTRL_PIN(207, "YIN0", UNIPHIER_PIN_IECTRL_NONE,
 			     193, UNIPHIER_PIN_DRV_1BIT,
@@ -1005,7 +1005,7 @@ static const struct pinctrl_pin_desc uniphier_pro4_pins[] = {
 			     311, UNIPHIER_PIN_DRV_1BIT,
 			     311, UNIPHIER_PIN_PULL_UP),
 	UNIPHIER_PINCTRL_PIN(328, "DMDISO", UNIPHIER_PIN_IECTRL_NONE,
-			     312, UNIPHIER_PIN_DRV_NONE,
+			     -1, UNIPHIER_PIN_DRV_NONE,
 			     312, UNIPHIER_PIN_PULL_DOWN),
 };
 
-- 
1.9.1
