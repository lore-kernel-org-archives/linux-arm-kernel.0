From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Wed,  6 Jul 2016 08:00:06 +0200
Subject: [PATCH] phy: sun9i-usb: fix error handling
Message-ID: <1467784806-17091-1-git-send-email-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is likely that checking 'phy->hsic_clk' instead of 'phy->clk' is
expected here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

---

v2: Also fix the variable name used by PTR_ERR
    Update $subject
---
 drivers/phy/phy-sun9i-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-sun9i-usb.c b/drivers/phy/phy-sun9i-usb.c
index ac4f31a..28fce4b 100644
--- a/drivers/phy/phy-sun9i-usb.c
+++ b/drivers/phy/phy-sun9i-usb.c
@@ -141,9 +141,9 @@ static int sun9i_usb_phy_probe(struct platform_device *pdev)
 		}
 
 		phy->hsic_clk = devm_clk_get(dev, "hsic_12M");
-		if (IS_ERR(phy->clk)) {
+		if (IS_ERR(phy->hsic_clk)) {
 			dev_err(dev, "failed to get hsic_12M clock\n");
-			return PTR_ERR(phy->clk);
+			return PTR_ERR(phy->hsic_clk);
 		}
 
 		phy->reset = devm_reset_control_get(dev, "hsic");
-- 
2.7.4
