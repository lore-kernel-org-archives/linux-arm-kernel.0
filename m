From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Jun 2017 14:29:52 +0200
Subject: [PATCH 2/2] pinctrl: armada-37xx: Fix number of pin in sdio_sb
In-Reply-To: <20170623122952.9871-1-gregory.clement@free-electrons.com>
References: <20170623122952.9871-1-gregory.clement@free-electrons.com>
Message-ID: <20170623122952.9871-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdio_sb group is composed of 6 pins and not 5.

Reported-by: Ken Ma <make@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 2fb1c67886fc..addc130159fc 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -160,8 +160,8 @@ static struct armada_37xx_pin_group armada_37xx_nb_groups[] = {
 static struct armada_37xx_pin_group armada_37xx_sb_groups[] = {
 	PIN_GRP_GPIO("usb32_drvvbus0", 0, 1, BIT(0), "drvbus"),
 	PIN_GRP_GPIO("usb2_drvvbus1", 1, 1, BIT(1), "drvbus"),
-	PIN_GRP_GPIO("sdio_sb", 24, 5, BIT(2), "sdio"),
-	PIN_GRP_EXTRA("rgmii", 6, 14, BIT(3), 0, BIT(3), 23, 1, "mii", "gpio"),
+	PIN_GRP_GPIO("sdio_sb", 24, 6, BIT(2), "sdio"),
+	PIN_GRP_EXTRA("rgmii", 6, 12, BIT(3), 0, BIT(3), 23, 1, "mii", "gpio"),
 	PIN_GRP_GPIO("pcie1", 3, 2, BIT(4), "pcie"),
 	PIN_GRP_GPIO("ptp", 20, 3, BIT(5), "ptp"),
 	PIN_GRP("ptp_clk", 21, 1, BIT(6), "ptp", "mii"),
-- 
2.11.0
