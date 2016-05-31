From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:05:19 +0900
Subject: [PATCH 13/17] pinctrl: uniphier: add dedicated pins to pin tables of
 PH1-LD4/sLD8
In-Reply-To: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1464681923-7469-14-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These pins do not support pin-muxing, but it is useful to support
pin configuration for them.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 31 ++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 46 ++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index 9b59f8d..6692e80 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -515,6 +515,37 @@ static const struct pinctrl_pin_desc uniphier_ld4_pins[] = {
 	UNIPHIER_PINCTRL_PIN(164, "NANDRYBY0", UNIPHIER_PIN_IECTRL_NONE,
 			     37, UNIPHIER_PIN_DRV_1BIT,
 			     37, UNIPHIER_PIN_PULL_UP),
+	/* dedicated pins */
+	UNIPHIER_PINCTRL_PIN(165, "ED0", -1,
+			     0, UNIPHIER_PIN_DRV_1BIT,
+			     0, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(166, "ED1", -1,
+			     1, UNIPHIER_PIN_DRV_1BIT,
+			     1, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(167, "ED2", -1,
+			     2, UNIPHIER_PIN_DRV_1BIT,
+			     2, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(168, "ED3", -1,
+			     3, UNIPHIER_PIN_DRV_1BIT,
+			     3, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(169, "ED4", -1,
+			     4, UNIPHIER_PIN_DRV_1BIT,
+			     4, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(170, "ED5", -1,
+			     5, UNIPHIER_PIN_DRV_1BIT,
+			     5, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(171, "ED6", -1,
+			     6, UNIPHIER_PIN_DRV_1BIT,
+			     6, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(172, "ED7", -1,
+			     7, UNIPHIER_PIN_DRV_1BIT,
+			     7, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(173, "ERXW", -1,
+			     26, UNIPHIER_PIN_DRV_1BIT,
+			     26, UNIPHIER_PIN_PULL_UP),
+	UNIPHIER_PINCTRL_PIN(174, "XECS1", -1,
+			     30, UNIPHIER_PIN_DRV_1BIT,
+			     30, UNIPHIER_PIN_PULL_UP),
 };
 
 static const unsigned emmc_pins[] = {21, 22, 23, 24, 25, 26, 27};
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index d8b3655..1bda223 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -428,6 +428,52 @@ static const struct pinctrl_pin_desc uniphier_sld8_pins[] = {
 	UNIPHIER_PINCTRL_PIN(135, "XIRQ7", 0,
 			     118, UNIPHIER_PIN_DRV_1BIT,
 			     118, UNIPHIER_PIN_PULL_DOWN),
+	/* dedicated pins */
+	UNIPHIER_PINCTRL_PIN(136, "ED0", -1,
+			     0, UNIPHIER_PIN_DRV_1BIT,
+			     0, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(137, "ED1", -1,
+			     1, UNIPHIER_PIN_DRV_1BIT,
+			     1, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(138, "ED2", -1,
+			     2, UNIPHIER_PIN_DRV_1BIT,
+			     2, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(139, "ED3", -1,
+			     3, UNIPHIER_PIN_DRV_1BIT,
+			     3, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(140, "ED4", -1,
+			     4, UNIPHIER_PIN_DRV_1BIT,
+			     4, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(141, "ED5", -1,
+			     5, UNIPHIER_PIN_DRV_1BIT,
+			     5, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(142, "ED6", -1,
+			     6, UNIPHIER_PIN_DRV_1BIT,
+			     6, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(143, "ED7", -1,
+			     7, UNIPHIER_PIN_DRV_1BIT,
+			     7, UNIPHIER_PIN_PULL_DOWN),
+	UNIPHIER_PINCTRL_PIN(144, "XERWE0", -1,
+			     8, UNIPHIER_PIN_DRV_1BIT,
+			     8, UNIPHIER_PIN_PULL_UP),
+	UNIPHIER_PINCTRL_PIN(145, "XERWE1", -1,
+			     9, UNIPHIER_PIN_DRV_1BIT,
+			     9, UNIPHIER_PIN_PULL_UP),
+	UNIPHIER_PINCTRL_PIN(146, "ERXW", -1,
+			     10, UNIPHIER_PIN_DRV_1BIT,
+			     10, UNIPHIER_PIN_PULL_UP),
+	UNIPHIER_PINCTRL_PIN(147, "ES0", -1,
+			     11, UNIPHIER_PIN_DRV_1BIT,
+			     11, UNIPHIER_PIN_PULL_UP),
+	UNIPHIER_PINCTRL_PIN(148, "ES1", -1,
+			     12, UNIPHIER_PIN_DRV_1BIT,
+			     12, UNIPHIER_PIN_PULL_UP),
+	UNIPHIER_PINCTRL_PIN(149, "ES2", -1,
+			     13, UNIPHIER_PIN_DRV_1BIT,
+			     13, UNIPHIER_PIN_PULL_UP),
+	UNIPHIER_PINCTRL_PIN(150, "XECS1", -1,
+			     14, UNIPHIER_PIN_DRV_1BIT,
+			     14, UNIPHIER_PIN_PULL_DOWN),
 };
 
 static const unsigned emmc_pins[] = {21, 22, 23, 24, 25, 26, 27};
-- 
1.9.1
