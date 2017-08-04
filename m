From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  4 Aug 2017 13:47:00 +0900
Subject: [PATCH] pinctrl: armada-37xx: add static to local data
Message-ID: <1501822020-22511-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Detected by sparse.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index f024e25787fc..0b263b90a9a8 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -179,14 +179,14 @@ static struct armada_37xx_pin_group armada_37xx_sb_groups[] = {
 	PIN_GRP("mii_col", 23, 1, BIT(8), "mii", "mii_err"),
 };
 
-const struct armada_37xx_pin_data armada_37xx_pin_nb = {
+static const struct armada_37xx_pin_data armada_37xx_pin_nb = {
 	.nr_pins = 36,
 	.name = "GPIO1",
 	.groups = armada_37xx_nb_groups,
 	.ngroups = ARRAY_SIZE(armada_37xx_nb_groups),
 };
 
-const struct armada_37xx_pin_data armada_37xx_pin_sb = {
+static const struct armada_37xx_pin_data armada_37xx_pin_sb = {
 	.nr_pins = 29,
 	.name = "GPIO2",
 	.groups = armada_37xx_sb_groups,
-- 
2.7.4
