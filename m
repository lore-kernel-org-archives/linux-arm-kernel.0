From: rogerq@ti.com (Roger Quadros)
Date: Wed, 18 Sep 2013 15:49:02 +0300
Subject: [PATCH v7 10/10] usb: phy: omap-usb2: Manage phy clock and not otg
 controller clock
In-Reply-To: <1379508542-22389-1-git-send-email-rogerq@ti.com>
References: <1379508542-22389-1-git-send-email-rogerq@ti.com>
Message-ID: <1379508542-22389-11-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OTG_SS controller driver manages the OTG_SS clock. The phy driver
needs to manage the PHY's functional clock. So correct the clock name.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/phy/phy-omap-usb2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-usb2.c b/drivers/usb/phy/phy-omap-usb2.c
index e7d4790..0fab250 100644
--- a/drivers/usb/phy/phy-omap-usb2.c
+++ b/drivers/usb/phy/phy-omap-usb2.c
@@ -179,9 +179,9 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 	clk_prepare(phy->wkupclk);
 
-	phy->optclk = devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
+	phy->optclk = devm_clk_get(phy->dev, "usb_phy_refclk960m");
 	if (IS_ERR(phy->optclk))
-		dev_vdbg(&pdev->dev, "unable to get refclk960m\n");
+		dev_dbg(&pdev->dev, "unable to get refclk960m\n");
 	else
 		clk_prepare(phy->optclk);
 
-- 
1.7.4.1
