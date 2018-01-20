From: david@lechnology.com (David Lechner)
Date: Fri, 19 Jan 2018 21:20:24 -0600
Subject: [PATCH 6/6] phy: da8xx-usb: drop use of
 syscon_regmap_lookup_by_pdevname()
In-Reply-To: <1516418424-28686-1-git-send-email-david@lechnology.com>
References: <1516418424-28686-1-git-send-email-david@lechnology.com>
Message-ID: <1516418424-28686-7-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This drops the use of syscon_regmap_lookup_by_pdevname() from the
DA8XX USB PHY driver. There are no longer any boards that register
a syscon platform device, so it is no longer needed.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/phy/ti/phy-da8xx-usb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/phy/ti/phy-da8xx-usb.c b/drivers/phy/ti/phy-da8xx-usb.c
index 4daa905..76f4fe9 100644
--- a/drivers/phy/ti/phy-da8xx-usb.c
+++ b/drivers/phy/ti/phy-da8xx-usb.c
@@ -153,8 +153,6 @@ static int da8xx_usb_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	d_phy->regmap = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
-	if (IS_ERR(d_phy->regmap))
-		d_phy->regmap = syscon_regmap_lookup_by_pdevname("syscon");
 	if (IS_ERR(d_phy->regmap)) {
 		dev_err(dev, "Failed to get syscon\n");
 		return PTR_ERR(d_phy->regmap);
-- 
2.7.4
