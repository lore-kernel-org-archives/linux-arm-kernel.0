From: hjp@liab.dk (Henrik Juul Pedersen)
Date: Mon, 6 Nov 2017 17:02:58 +0100
Subject: [PATCH] pinctrl: Fix armada-37xx pmic pin group numbering
Message-ID: <CABQZ+_QYDE9k31ywvHqSEsNPjsnGQHMd0oCyErKFAT1PpETkEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix pin numbering in Marvell ARMADA 37xx pincontroller.

The pmic0 and pmic1 pin groups start on pins 6 and 7 respectively.

Signed-off-by: Henrik Juul Pedersen <hjp@liab.dk>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 71b94474..e223fac2 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -157,8 +157,8 @@ static struct armada_37xx_pin_group
armada_37xx_nb_groups[] = {
  PIN_GRP_GPIO("pwm1", 12, 1, BIT(4), "pwm"),
  PIN_GRP_GPIO("pwm2", 13, 1, BIT(5), "pwm"),
  PIN_GRP_GPIO("pwm3", 14, 1, BIT(6), "pwm"),
- PIN_GRP_GPIO("pmic1", 17, 1, BIT(7), "pmic"),
- PIN_GRP_GPIO("pmic0", 16, 1, BIT(8), "pmic"),
+ PIN_GRP_GPIO("pmic1", 7, 1, BIT(7), "pmic"),
+ PIN_GRP_GPIO("pmic0", 6, 1, BIT(8), "pmic"),
  PIN_GRP_GPIO("i2c2", 2, 2, BIT(9), "i2c"),
  PIN_GRP_GPIO("i2c1", 0, 2, BIT(10), "i2c"),
  PIN_GRP_GPIO("spi_cs1", 17, 1, BIT(12), "spi"),
-- 
2.14.1
