From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 15 Jun 2016 17:18:05 +0900
Subject: [PATCH 1/2] pinctrl: uniphier: prohibit drive control for pin 61-66
 of PH1-LD11
In-Reply-To: <1465978686-28578-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465978686-28578-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1465978686-28578-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the hardware document, setting the drive control is
prohibited for these pins (N-channel Open Drain pins).  Set their
drive control attribute to "fixed".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index 150942f..608cd73 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -151,22 +151,22 @@ static const struct pinctrl_pin_desc uniphier_ld11_pins[] = {
 			     60, UNIPHIER_PIN_DRV_1BIT,
 			     60, UNIPHIER_PIN_PULL_DOWN),
 	UNIPHIER_PINCTRL_PIN(61, "DMDSDA0", 61,
-			     61, UNIPHIER_PIN_DRV_1BIT,
+			     -1, UNIPHIER_PIN_DRV_FIXED4,
 			     -1, UNIPHIER_PIN_PULL_NONE),
 	UNIPHIER_PINCTRL_PIN(62, "DMDSCL0", 62,
-			     62, UNIPHIER_PIN_DRV_1BIT,
+			     -1, UNIPHIER_PIN_DRV_FIXED4,
 			     -1, UNIPHIER_PIN_PULL_NONE),
 	UNIPHIER_PINCTRL_PIN(63, "SDA0", 63,
-			     63, UNIPHIER_PIN_DRV_1BIT,
+			     -1, UNIPHIER_PIN_DRV_FIXED4,
 			     -1, UNIPHIER_PIN_PULL_NONE),
 	UNIPHIER_PINCTRL_PIN(64, "SCL0", 64,
-			     64, UNIPHIER_PIN_DRV_1BIT,
+			     -1, UNIPHIER_PIN_DRV_FIXED4,
 			     -1, UNIPHIER_PIN_PULL_NONE),
 	UNIPHIER_PINCTRL_PIN(65, "SDA1", 65,
-			     65, UNIPHIER_PIN_DRV_1BIT,
+			     -1, UNIPHIER_PIN_DRV_FIXED4,
 			     -1, UNIPHIER_PIN_PULL_NONE),
 	UNIPHIER_PINCTRL_PIN(66, "SCL1", 66,
-			     66, UNIPHIER_PIN_DRV_1BIT,
+			     -1, UNIPHIER_PIN_DRV_FIXED4,
 			     -1, UNIPHIER_PIN_PULL_NONE),
 	UNIPHIER_PINCTRL_PIN(67, "HIN", 67,
 			     -1, UNIPHIER_PIN_DRV_FIXED5,
-- 
1.9.1
