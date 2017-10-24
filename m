From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Oct 2017 13:11:11 +0900
Subject: [PATCH] pinctrl: uniphier: remove eMMC hardware reset pin-mux
Message-ID: <1508818271-6298-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is handled by the mmc-pwrseq-emmc driver, which controls
an eMMC hardware reset via a GPIO line.

Remove it from the function pin-mux settings.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 4 ++--
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 4 ++--
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index 9c5e359..8a5ecd6 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -472,8 +472,8 @@ static const struct pinctrl_pin_desc uniphier_ld11_pins[] = {
 
 static const unsigned aout_pins[] = {135, 136, 137, 138, 139, 140, 141, 142};
 static const int aout_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0};
-static const unsigned emmc_pins[] = {18, 19, 20, 21, 22, 23, 24, 25};
-static const int emmc_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned int emmc_pins[] = {19, 20, 21, 22, 23, 24, 25};
+static const int emmc_muxvals[] = {0, 0, 0, 0, 0, 0, 0};
 static const unsigned emmc_dat8_pins[] = {26, 27, 28, 29};
 static const int emmc_dat8_muxvals[] = {0, 0, 0, 0};
 static const unsigned ether_rmii_pins[] = {6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
index 8334128..3be7967 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
@@ -553,8 +553,8 @@ static const struct pinctrl_pin_desc uniphier_ld20_pins[] = {
 
 static const unsigned aout_pins[] = {135, 136, 137, 138, 139, 140, 141, 142};
 static const int aout_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0};
-static const unsigned emmc_pins[] = {18, 19, 20, 21, 22, 23, 24, 25};
-static const int emmc_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned int emmc_pins[] = {19, 20, 21, 22, 23, 24, 25};
+static const int emmc_muxvals[] = {0, 0, 0, 0, 0, 0, 0};
 static const unsigned emmc_dat8_pins[] = {26, 27, 28, 29};
 static const int emmc_dat8_muxvals[] = {0, 0, 0, 0};
 static const unsigned ether_rgmii_pins[] = {30, 31, 32, 33, 34, 35, 36, 37, 38,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
index d9f166f..dbe94a9 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
@@ -776,8 +776,8 @@ static const struct pinctrl_pin_desc uniphier_pxs3_pins[] = {
 			     250, UNIPHIER_PIN_PULL_DOWN),
 };
 
-static const unsigned int emmc_pins[] = {31, 32, 33, 34, 35, 36, 37, 38};
-static const int emmc_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned int emmc_pins[] = {32, 33, 34, 35, 36, 37, 38};
+static const int emmc_muxvals[] = {0, 0, 0, 0, 0, 0, 0};
 static const unsigned int emmc_dat8_pins[] = {39, 40, 41, 42};
 static const int emmc_dat8_muxvals[] = {0, 0, 0, 0};
 static const unsigned int ether_rgmii_pins[] = {52, 53, 54, 55, 56, 57, 58, 59,
-- 
2.7.4
