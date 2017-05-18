From: colin.king@canonical.com (Colin King)
Date: Thu, 18 May 2017 10:22:34 +0100
Subject: [PATCH] phy: rockchip-typec: make dp_pll_cfg and usb3_pll_cfg static
Message-ID: <20170518092234.13276-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

arrays dp_pll_cfg and usb3_pll_cfg can be made static as they do
not need to be in global scope. Also make them const.

Cleans up sparse warnings:
  warning: symbol 'dp_pll_cfg' was not declared. Should it be static?
  warning: symbol 'usb3_pll_cfg' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/phy/phy-rockchip-typec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-rockchip-typec.c b/drivers/phy/phy-rockchip-typec.c
index 7cfb0f8995de..66b54a6f00f6 100644
--- a/drivers/phy/phy-rockchip-typec.c
+++ b/drivers/phy/phy-rockchip-typec.c
@@ -292,7 +292,7 @@ struct phy_reg {
 	u32 addr;
 };
 
-struct phy_reg usb3_pll_cfg[] = {
+static const struct phy_reg usb3_pll_cfg[] = {
 	{ 0xf0,		CMN_PLL0_VCOCAL_INIT },
 	{ 0x18,		CMN_PLL0_VCOCAL_ITER },
 	{ 0xd0,		CMN_PLL0_INTDIV },
@@ -309,7 +309,7 @@ struct phy_reg usb3_pll_cfg[] = {
 	{ 0x8,		CMN_DIAG_PLL0_LF_PROG },
 };
 
-struct phy_reg dp_pll_cfg[] = {
+static const struct phy_reg dp_pll_cfg[] = {
 	{ 0xf0,		CMN_PLL1_VCOCAL_INIT },
 	{ 0x18,		CMN_PLL1_VCOCAL_ITER },
 	{ 0x30b9,	CMN_PLL1_VCOCAL_START },
-- 
2.11.0
