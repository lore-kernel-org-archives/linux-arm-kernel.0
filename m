From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  7 Jun 2016 10:36:05 +0900
Subject: [PATCH] pinctrl: uniphier: fix NAND pin-mux settings for PH1-LD11/LD20
Message-ID: <1465263365-13966-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My mistake in the initial support patches.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index 418ccd6..150942f 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -484,7 +484,7 @@ static const unsigned i2c4_pins[] = {61, 62};
 static const int i2c4_muxvals[] = {1, 1};
 static const unsigned nand_pins[] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
 				     15, 16, 17};
-static const int nand_muxvals[] = {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2};
+static const int nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned sd_pins[] = {10, 11, 12, 13, 14, 15, 16, 17};
 static const int sd_muxvals[] = {3, 3, 3, 3, 3, 3, 3, 3};  /* No SDVOLC */
 static const unsigned system_bus_pins[] = {1, 2, 6, 7, 8, 9, 10, 11, 12, 13,
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
index 2cb26b7..7311453 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
@@ -565,7 +565,7 @@ static const unsigned i2c4_pins[] = {61, 62};
 static const int i2c4_muxvals[] = {1, 1};
 static const unsigned nand_pins[] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
 				     15, 16, 17};
-static const int nand_muxvals[] = {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2};
+static const int nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned sd_pins[] = {10, 11, 12, 13, 14, 15, 16, 17};
 static const int sd_muxvals[] = {3, 3, 3, 3, 3, 3, 3, 3};  /* No SDVOLC */
 static const unsigned system_bus_pins[] = {1, 2, 6, 7, 8, 9, 10, 11, 12, 13,
-- 
1.9.1
