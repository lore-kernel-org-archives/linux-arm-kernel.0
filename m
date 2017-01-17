From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 17 Jan 2017 19:52:54 +0900
Subject: [PATCH] pinctrl: uniphier: fix Ethernet (RMII) pin-mux setting for
 LD20
Message-ID: <1484650374-30989-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the pin-mux values for the MDC, MDIO, MDIO_INTL, PHYRSTL pins.

Fixes: 1e359ab1285e ("pinctrl: uniphier: add Ethernet pin-mux settings")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
index aa8bd97..9668633 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
@@ -561,7 +561,7 @@ static const int ether_rgmii_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 					  0, 0, 0, 0};
 static const unsigned ether_rmii_pins[] = {30, 31, 32, 33, 34, 35, 36, 37, 39,
 					   41, 42, 45};
-static const int ether_rmii_muxvals[] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
+static const int ether_rmii_muxvals[] = {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1};
 static const unsigned i2c0_pins[] = {63, 64};
 static const int i2c0_muxvals[] = {0, 0};
 static const unsigned i2c1_pins[] = {65, 66};
-- 
2.7.4
